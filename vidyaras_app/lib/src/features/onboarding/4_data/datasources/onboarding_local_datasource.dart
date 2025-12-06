import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/models/onboarding_data.dart';

/// Local data source for onboarding data using Supabase profiles table
/// Handles all interactions with profiles table for onboarding preferences
class OnboardingLocalDataSource {
  final SupabaseClient _supabase;

  OnboardingLocalDataSource(this._supabase);

  /// Save onboarding data to profiles table
  Future<void> saveOnboardingData(OnboardingData data) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Convert onboarding data to JSON for preferences column
      final preferences = data.toJson();

      // Update profiles table with preferences and mark as onboarded
      await _supabase.from('profiles').update({
        'preferences': preferences,
        'is_onboarded': true,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to save onboarding data: $e');
    }
  }

  /// Retrieve onboarding data from profiles table
  /// Returns null if no data exists or user not authenticated
  Future<OnboardingData?> getOnboardingData() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return null;
      }

      final profile = await _supabase
          .from('profiles')
          .select('preferences')
          .eq('id', userId)
          .maybeSingle();

      if (profile == null || profile['preferences'] == null) {
        return null;
      }

      final preferencesMap = profile['preferences'] as Map<String, dynamic>;
      return OnboardingData.fromJson(preferencesMap);
    } catch (e) {
      throw Exception('Failed to retrieve onboarding data: $e');
    }
  }

  /// Check if onboarding has been completed by checking is_onboarded flag
  Future<bool> hasCompletedOnboarding() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return false;
      }

      final profile = await _supabase
          .from('profiles')
          .select('is_onboarded')
          .eq('id', userId)
          .maybeSingle();

      if (profile == null) {
        return false;
      }

      return profile['is_onboarded'] == true;
    } catch (e) {
      throw Exception('Failed to check onboarding status: $e');
    }
  }

  /// Clear onboarding data from profiles table (sets is_onboarded to false)
  /// This is primarily for testing or resetting onboarding flow
  Future<void> clearOnboardingData() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await _supabase.from('profiles').update({
        'preferences': {},
        'is_onboarded': false,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to clear onboarding data: $e');
    }
  }
}
