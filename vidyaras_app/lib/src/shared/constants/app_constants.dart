/// Application-wide constants
/// Contains company info, external links, and configuration values
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'VidyaRas';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'A bilingual learning ecosystem for traditional Indian arts, wellness, and personal development.';
  static const String copyrightText = '© 2025 VidyaRas. All rights reserved.';

  // Company Information
  static const String companyName = 'VidyaRas';
  static const String companyWebsite = 'https://vidyaras.com';
  static const String companyEmail = 'contact@vidyaras.com';
  static const String supportEmail = 'support@vidyaras.com';

  // Social Media Links
  static const String facebookUrl = 'https://www.facebook.com/vidyaras';
  static const String instagramUrl = 'https://www.instagram.com/vidyaras';
  static const String twitterUrl = 'https://twitter.com/vidyaras';
  static const String linkedinUrl = 'https://www.linkedin.com/company/vidyaras';
  static const String youtubeUrl = 'https://www.youtube.com/@MohitDobhalOfficial';

  // Legal & Policy Links
  static const String privacyPolicyUrl = 'https://vidyaras.com/privacy-policy';
  static const String termsAndConditionsUrl =
      'https://vidyaras.com/terms-and-conditions';
  static const String refundPolicyUrl = 'https://vidyaras.com/refund-policy';
  static const String aboutUsUrl = 'https://vidyaras.com/about';
  static const String contactUsUrl = 'https://vidyaras.com/contact';
  static const String faqUrl = 'https://vidyaras.com/faq';

  // App Store Links
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.vidyaras.app';
  static const String appStoreUrl =
      'https://apps.apple.com/app/vidyaras/id123456789';

  // Contact Methods
  static const String whatsappNumber = '+919876543210';
  static const String phoneNumber = '+919876543210';
  static const String whatsappUrl =
      'https://wa.me/$whatsappNumber?text=Hi%20VidyaRas%20Team';

  // Course Categories
  static const List<String> courseCategories = [
    'Music',
    'Wellness',
    'Yoga',
    'Arts',
    'Life Skills',
    'Dance',
    'Meditation',
  ];

  // Feature Tags
  static const String liveClassesTag = 'Live Classes';
  static const String recordedCoursesTag = 'Recorded Courses';
  static const String certificatesTag = 'Certificates';
  static const String communityTag = 'Community';

  // API Configuration (if needed)
  static const String apiBaseUrl = 'https://api.vidyaras.com/v1';

  // Pagination
  static const int coursesPerPage = 10;
  static const int defaultPageSize = 20;

  // Media
  static const int maxImageSizeMB = 5;
  static const int maxVideoSizeMB = 100;

  // Session Configuration
  static const int sessionTimeoutMinutes = 30;
  static const int maxLoginAttempts = 5;

  // Referral System
  static const int referralPointsPerInvite = 50;
  static const int referralBonusThreshold = 5;

  // Support & Help
  static const String helpCenterUrl = 'https://vidyaras.com/help';
  static const String tutorialsUrl = 'https://vidyaras.com/tutorials';
  static const String communityForumUrl = 'https://community.vidyaras.com';

  // About Content
  static const String missionStatement =
      'To preserve and promote traditional Indian arts, wellness practices, and holistic learning through accessible, bilingual digital education.';

  static const String visionStatement =
      'Becoming the leading platform for authentic traditional Indian knowledge, empowering learners worldwide to connect with their cultural heritage.';

  // Features List
  static const List<Map<String, String>> appFeatures = [
    {
      'icon': 'live_tv',
      'title': 'Live Classes',
      'description': 'Interactive sessions with expert instructors',
    },
    {
      'icon': 'video_library',
      'title': 'Recorded Courses',
      'description': 'Learn at your own pace with on-demand content',
    },
    {
      'icon': 'groups',
      'title': 'Community',
      'description': 'Connect with fellow learners and instructors',
    },
    {
      'icon': 'workspace_premium',
      'title': 'Certificates',
      'description': 'Earn recognized certificates upon completion',
    },
    {
      'icon': 'translate',
      'title': 'Bilingual',
      'description': 'Available in Hindi and English',
    },
    {
      'icon': 'devices',
      'title': 'Multi-Device',
      'description': 'Access across mobile, tablet, and web',
    },
  ];
}
