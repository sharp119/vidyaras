import 'package:hive/hive.dart';
import '../../3_domain/models/onboarding_data.dart';

/// Local data source for onboarding data using Hive
/// Handles all interactions with local storage for onboarding preferences
class OnboardingLocalDataSource {
  static const String _boxName = 'onboarding';
  static const String _dataKey = 'onboarding_data';

  /// Get Hive box for onboarding data
  Future<Box> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox(_boxName);
    }
    return Hive.box(_boxName);
  }

  /// Save onboarding data to Hive
  Future<void> saveOnboardingData(OnboardingData data) async {
    try {
      final box = await _getBox();
      final json = data.toJson();
      await box.put(_dataKey, json);
    } catch (e) {
      throw Exception('Failed to save onboarding data: $e');
    }
  }

  /// Retrieve onboarding data from Hive
  /// Returns null if no data exists
  Future<OnboardingData?> getOnboardingData() async {
    try {
      final box = await _getBox();
      final json = box.get(_dataKey);

      if (json == null) {
        return null;
      }

      return OnboardingData.fromJson(Map<String, dynamic>.from(json));
    } catch (e) {
      throw Exception('Failed to retrieve onboarding data: $e');
    }
  }

  /// Check if onboarding has been completed
  Future<bool> hasCompletedOnboarding() async {
    try {
      final box = await _getBox();
      return box.containsKey(_dataKey);
    } catch (e) {
      throw Exception('Failed to check onboarding status: $e');
    }
  }

  /// Clear onboarding data from Hive
  Future<void> clearOnboardingData() async {
    try {
      final box = await _getBox();
      await box.delete(_dataKey);
    } catch (e) {
      throw Exception('Failed to clear onboarding data: $e');
    }
  }
}
