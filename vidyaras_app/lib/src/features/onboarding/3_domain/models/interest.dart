/// Enum representing user interests for onboarding
enum Interest {
  music,
  wellness,
  yoga,
  artsDance,
  lifeSkills;

  /// Display name in English
  String get displayNameEnglish {
    switch (this) {
      case Interest.music:
        return 'Music';
      case Interest.wellness:
        return 'Wellness';
      case Interest.yoga:
        return 'Yoga';
      case Interest.artsDance:
        return 'Arts & Dance';
      case Interest.lifeSkills:
        return 'Life Skills';
    }
  }

  /// Display name in Hindi
  String get displayNameHindi {
    switch (this) {
      case Interest.music:
        return 'संगीत';
      case Interest.wellness:
        return 'स्वास्थ्य';
      case Interest.yoga:
        return 'योग';
      case Interest.artsDance:
        return 'कला और नृत्य';
      case Interest.lifeSkills:
        return 'जीवन कौशल';
    }
  }

  /// Emoji/icon representation
  String get emoji {
    switch (this) {
      case Interest.music:
        return '🎵';
      case Interest.wellness:
        return '🧘';
      case Interest.yoga:
        return '🕉️';
      case Interest.artsDance:
        return '💃';
      case Interest.lifeSkills:
        return '✨';
    }
  }
}
