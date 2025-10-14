/// Enum representing user experience level for onboarding
enum ExperienceLevel {
  beginner,
  intermediate,
  advanced;

  /// Display name in English
  String get displayNameEnglish {
    switch (this) {
      case ExperienceLevel.beginner:
        return 'Beginner';
      case ExperienceLevel.intermediate:
        return 'Intermediate';
      case ExperienceLevel.advanced:
        return 'Advanced';
    }
  }

  /// Display name in Hindi
  String get displayNameHindi {
    switch (this) {
      case ExperienceLevel.beginner:
        return 'शुरुआती';
      case ExperienceLevel.intermediate:
        return 'मध्यवर्ती';
      case ExperienceLevel.advanced:
        return 'उन्नत';
    }
  }

  /// Description in English
  String get descriptionEnglish {
    switch (this) {
      case ExperienceLevel.beginner:
        return 'Just starting out';
      case ExperienceLevel.intermediate:
        return 'Some experience';
      case ExperienceLevel.advanced:
        return 'Experienced learner';
    }
  }

  /// Description in Hindi
  String get descriptionHindi {
    switch (this) {
      case ExperienceLevel.beginner:
        return 'अभी शुरुआत कर रहे हैं';
      case ExperienceLevel.intermediate:
        return 'कुछ अनुभव है';
      case ExperienceLevel.advanced:
        return 'अनुभवी शिक्षार्थी';
    }
  }

  /// Emoji/icon representation
  String get emoji {
    switch (this) {
      case ExperienceLevel.beginner:
        return '🌱';
      case ExperienceLevel.intermediate:
        return '🌿';
      case ExperienceLevel.advanced:
        return '🌳';
    }
  }
}
