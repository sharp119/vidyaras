/// Enum representing user learning goals for onboarding
enum LearningGoal {
  exams,
  hobby,
  professional,
  cultural,
  wellness;

  /// Display name in English
  String get displayNameEnglish {
    switch (this) {
      case LearningGoal.exams:
        return 'Prepare for exams';
      case LearningGoal.hobby:
        return 'Learn as a hobby';
      case LearningGoal.professional:
        return 'Professional development';
      case LearningGoal.cultural:
        return 'Cultural preservation';
      case LearningGoal.wellness:
        return 'Personal wellness';
    }
  }

  /// Display name in Hindi
  String get displayNameHindi {
    switch (this) {
      case LearningGoal.exams:
        return 'परीक्षा की तैयारी';
      case LearningGoal.hobby:
        return 'शौक के रूप में सीखें';
      case LearningGoal.professional:
        return 'व्यावसायिक विकास';
      case LearningGoal.cultural:
        return 'सांस्कृतिक संरक्षण';
      case LearningGoal.wellness:
        return 'व्यक्तिगत स्वास्थ्य';
    }
  }

  /// Emoji/icon representation
  String get emoji {
    switch (this) {
      case LearningGoal.exams:
        return '📚';
      case LearningGoal.hobby:
        return '🎨';
      case LearningGoal.professional:
        return '💼';
      case LearningGoal.cultural:
        return '🏛️';
      case LearningGoal.wellness:
        return '🌱';
    }
  }
}
