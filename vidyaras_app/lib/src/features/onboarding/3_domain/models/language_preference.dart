/// Enum representing user language preference for onboarding
enum LanguagePreference {
  hindi,
  english,
  both;

  /// Display name in English
  String get displayNameEnglish {
    switch (this) {
      case LanguagePreference.hindi:
        return 'Hindi';
      case LanguagePreference.english:
        return 'English';
      case LanguagePreference.both:
        return 'Both (Bilingual)';
    }
  }

  /// Display name in Hindi
  String get displayNameHindi {
    switch (this) {
      case LanguagePreference.hindi:
        return 'हिंदी';
      case LanguagePreference.english:
        return 'अंग्रेज़ी';
      case LanguagePreference.both:
        return 'दोनों (द्विभाषी)';
    }
  }

  /// Emoji/icon representation
  String get emoji {
    switch (this) {
      case LanguagePreference.hindi:
        return '🇮🇳';
      case LanguagePreference.english:
        return '🇬🇧';
      case LanguagePreference.both:
        return '🌐';
    }
  }

  /// Language code for app localization
  String get languageCode {
    switch (this) {
      case LanguagePreference.hindi:
        return 'hi';
      case LanguagePreference.english:
        return 'en';
      case LanguagePreference.both:
        return 'both'; // App will show bilingual content
    }
  }
}
