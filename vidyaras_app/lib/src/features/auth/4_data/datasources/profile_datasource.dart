import 'package:supabase_flutter/supabase_flutter.dart';

/// ProfileDataSource
/// Handles CRUD operations for the profiles table
/// This is in the Data Layer - raw database operations only
class ProfileDataSource {
  final SupabaseClient _supabase;

  ProfileDataSource(this._supabase);

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
}
