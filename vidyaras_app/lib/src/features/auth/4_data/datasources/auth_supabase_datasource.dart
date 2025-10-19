import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';
import '../../3_domain/models/user.dart' as domain;

/// Auth datasource using Supabase
/// Handles user creation and retrieval via direct database operations
/// Uses manual session handling with Hive for persistence
class AuthSupabaseDataSource {
  final SupabaseClient _supabase;
  static const String _sessionBoxName = 'auth_session';
  static const String _currentUserKey = 'current_user';
  static const String _sessionExpiryKey = 'session_expiry';

  // Session expiry: 30 days
  static const int _sessionExpiryDays = 30;

  AuthSupabaseDataSource(this._supabase);

  /// Create or get user by phone number
  /// Directly inserts/updates in the users table
  ///
  /// Returns:
  /// - User object if user exists or was created successfully
  /// - Throws exception if there's an error
  Future<domain.User> createOrGetUser({
    required String phoneNumber,
    String? name,
    String? email,
  }) async {
    try {
      print('📞 Checking if user exists: $phoneNumber');

      // Check if user already exists
      final existingUserResponse = await _supabase
          .from('users')
          .select()
          .eq('phone_number', phoneNumber)
          .maybeSingle();

      if (existingUserResponse != null) {
        print('✅ User already exists, logging in...');

        // Update user info if name or email provided
        if (name != null || email != null) {
          print('📝 Updating user profile...');
          final updates = {
            if (name != null && name.isNotEmpty) 'name': name,
            if (email != null && email.isNotEmpty) 'email': email,
            'updated_at': DateTime.now().toIso8601String(),
          };

          final updatedResponse = await _supabase
              .from('users')
              .update(updates)
              .eq('phone_number', phoneNumber)
              .select()
              .single();

          final user = _mapDatabaseUserToDomain(updatedResponse);
          await _saveUserToLocal(user);
          return user;
        }

        final user = _mapDatabaseUserToDomain(existingUserResponse);
        await _saveUserToLocal(user);
        return user;
      }

      // User doesn't exist, create new user
      print('🆕 Creating new user in database...');

      final newUserData = {
        'phone_number': phoneNumber,
        if (name != null && name.isNotEmpty) 'name': name,
        if (email != null && email.isNotEmpty) 'email': email,
      };

      final response = await _supabase
          .from('users')
          .insert(newUserData)
          .select()
          .single();

      print('✅ User created successfully');

      final user = _mapDatabaseUserToDomain(response);
      await _saveUserToLocal(user);
      return user;
    } catch (e) {
      print('❌ Error in createOrGetUser: $e');
      rethrow;
    }
  }

  /// Map database row to domain User model
  domain.User _mapDatabaseUserToDomain(Map<String, dynamic> data) {
    return domain.User(
      id: data['id'] as String,
      phoneNumber: data['phone_number'] as String,
      name: data['name'] as String? ?? '',
      email: data['email'] as String?,
      isNewUser: (data['name'] as String?)?.isEmpty ?? true,
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String)
          : null,
    );
  }

  /// Save user to local storage (Hive) with session expiry
  Future<void> _saveUserToLocal(domain.User user) async {
    try {
      final box = await Hive.openBox(_sessionBoxName);
      final userJson = {
        'id': user.id,
        'phone_number': user.phoneNumber,
        'name': user.name,
        'email': user.email,
        'is_new_user': user.isNewUser,
        'created_at': user.createdAt?.toIso8601String(),
      };

      // Calculate session expiry time (30 days from now)
      final expiryTime = DateTime.now()
          .add(Duration(days: _sessionExpiryDays))
          .toIso8601String();

      await box.put(_currentUserKey, userJson);
      await box.put(_sessionExpiryKey, expiryTime);
      print('💾 User saved to local storage with expiry: $expiryTime');
    } catch (e) {
      print('❌ Error saving user to local storage: $e');
    }
  }

  /// Get currently authenticated user from local storage
  /// Returns null if session expired or user not found
  Future<domain.User?> getCurrentUser() async {
    try {
      final box = await Hive.openBox(_sessionBoxName);

      // Check session expiry
      final expiryString = box.get(_sessionExpiryKey) as String?;
      if (expiryString != null) {
        final expiryTime = DateTime.parse(expiryString);
        if (DateTime.now().isAfter(expiryTime)) {
          print('⏰ Session expired, clearing local storage');
          await box.delete(_currentUserKey);
          await box.delete(_sessionExpiryKey);
          return null;
        }
      }

      final userJson = box.get(_currentUserKey) as Map<dynamic, dynamic>?;

      if (userJson == null) {
        print('No user found in local storage');
        return null;
      }

      final user = domain.User(
        id: userJson['id'] as String,
        phoneNumber: userJson['phone_number'] as String,
        name: userJson['name'] as String? ?? '',
        email: userJson['email'] as String?,
        isNewUser: userJson['is_new_user'] as bool? ?? false,
        createdAt: userJson['created_at'] != null
            ? DateTime.parse(userJson['created_at'] as String)
            : null,
      );

      print('✅ User loaded from local storage: ${user.phoneNumber}');
      return user;
    } catch (e) {
      print('❌ Error getting current user: $e');
      return null;
    }
  }

  /// Sign out current user
  Future<bool> signOut() async {
    try {
      final box = await Hive.openBox(_sessionBoxName);
      await box.delete(_currentUserKey);
      await box.delete(_sessionExpiryKey);
      print('👋 User signed out and session cleared');
      return true;
    } catch (e) {
      print('❌ Error signing out: $e');
      return false;
    }
  }
}
