import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

/// ProfileDataSource
/// Handles CRUD operations for the profiles table
/// This is in the Data Layer - raw database operations and API calls
class ProfileDataSource {
  final SupabaseClient _supabase;
  final Dio _dio;

  ProfileDataSource(this._supabase, this._dio);

  /// Get current user's profile from profiles table
  /// Returns null if user not authenticated or profile not found
  Future<Map<String, dynamic>?> getCurrentProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return null;

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return response;
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  /// Update phone number
  /// Throws PostgrestException if duplicate (unique constraint violation code: 23505)
  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('profiles').update({
        'phone_number': phoneNumber,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } on PostgrestException catch (e) {
      // Re-throw with code preserved for handling in repository
      throw PostgrestException(
        message: e.message,
        code: e.code,
        details: e.details,
        hint: e.hint,
      );
    } catch (e) {
      throw Exception('Failed to update phone number: $e');
    }
  }

  /// Update onboarding completion and preferences
  Future<void> completeOnboarding(Map<String, dynamic> preferences) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      await _supabase.from('profiles').update({
        'preferences': preferences,
        'is_onboarded': true,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to complete onboarding: $e');
    }
  }

  /// Check if phone number exists in profiles table
  /// Returns true if exists (used for validation)
  Future<bool> phoneExists(String phoneNumber) async {
    try {
      final result = await _supabase
          .from('profiles')
          .select('id')
          .eq('phone_number', phoneNumber)
          .maybeSingle();

      return result != null;
    } catch (e) {
      throw Exception('Failed to check phone existence: $e');
    }
  }

  /// Get profile by ID (for admin features)
  Future<Map<String, dynamic>?> getProfileById(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return response;
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  /// Update profile fields (generic update)
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final updatesWithTimestamp = {
        ...updates,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _supabase
          .from('profiles')
          .update(updatesWithTimestamp)
          .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  /// Update profile via API endpoint
  /// Calls PATCH /api/users/me/profile
  /// Accepts: bio, full_name, name
  Future<Map<String, dynamic>> updateProfileViaAPI({
    String? bio,
    String? fullName,
    String? name,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (bio != null) updates['bio'] = bio;
      if (fullName != null) updates['full_name'] = fullName;
      if (name != null) updates['name'] = name;

      if (updates.isEmpty) {
        throw Exception('No fields to update');
      }

      final response = await _dio.patch(
        '/api/users/me/profile',
        data: updates,
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update profile: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(
        'API Error: ${e.response?.statusCode} - ${e.response?.data?['error'] ?? e.message}',
      );
    } catch (e) {
      throw Exception('Failed to update profile via API: $e');
    }
  }

  /// Upload avatar to Supabase Storage and update profile
  /// 1. Uploads file to avatars bucket with user ID prefix
  /// 2. Gets public URL
  /// 3. Calls POST /api/users/me/avatar to update profile
  Future<String> uploadAvatar(File imageFile) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      // Generate unique filename with user ID prefix
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = imageFile.path.split('.').last;
      final fileName = '$userId/$timestamp.$extension';

      // Upload to Supabase Storage
      final uploadPath = await _supabase.storage
          .from('avatars')
          .upload(fileName, imageFile);

      // Get public URL
      final publicUrl = _supabase.storage.from('avatars').getPublicUrl(uploadPath);

      // Update profile via API
      final response = await _dio.post(
        '/api/users/me/avatar',
        data: {'avatar_url': publicUrl},
      );

      if (response.statusCode == 200) {
        return publicUrl;
      } else {
        throw Exception('Failed to update avatar URL: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(
        'API Error: ${e.response?.statusCode} - ${e.response?.data?['error'] ?? e.message}',
      );
    } catch (e) {
      throw Exception('Failed to upload avatar: $e');
    }
  }

  /// Get user statistics from API
  /// Calls GET /api/users/me/statistics
  /// Returns stats including enrollments, completions, referral points, etc.
  Future<Map<String, dynamic>> getUserStatistics() async {
    try {
      final response = await _dio.get('/api/users/me/statistics');

      if (response.statusCode == 200 && response.data != null) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch statistics: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(
        'API Error: ${e.response?.statusCode} - ${e.response?.data?['error'] ?? e.message}',
      );
    } catch (e) {
      throw Exception('Failed to fetch user statistics: $e');
    }
  }
}
