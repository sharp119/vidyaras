# VidyaRas Component Usage Guide

This guide provides detailed usage instructions for all 28 reusable UI components extracted from the mockups and implemented following the Feature-First Layered Architecture.

---

## 📍 Component Locations

All components are located in:
```
lib/src/shared/presentation/components/
├── buttons/        # 6 button components
├── inputs/         # 3 input field components
├── typography/     # 3 typography components
├── layout/         # 4 layout components
├── cards/          # 5 card components
├── navigation/     # 3 navigation components
└── progress/       # 4 progress indicator components
```

Theme files:
```
lib/src/shared/presentation/theme/
├── app_colors.dart      # Color palette
├── app_gradients.dart   # Gradient definitions
└── app_theme.dart       # Theme configuration
```

---

## 🎨 Theme System

### Colors

Import and use predefined colors:

```dart
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

// Primary colors
AppColors.primary        // Indigo/Blue (#6366F1)
AppColors.secondary      // Purple (#A855F7)
AppColors.accent         // Orange (#F97316)

// Text colors
AppColors.textPrimary    // Dark gray
AppColors.textSecondary  // Medium gray
AppColors.textTertiary   // Light gray

// Status colors
AppColors.success        // Green
AppColors.error          // Red
AppColors.warning        // Amber
```

### Gradients

```dart
import 'package:vidyaras_app/src/shared/presentation/theme/app_gradients.dart';

// Use predefined gradients
Container(
  decoration: BoxDecoration(
    gradient: AppGradients.primary,  // Blue to Purple
    borderRadius: BorderRadius.circular(12),
  ),
)

// Available gradients:
AppGradients.primary      // Blue → Purple
AppGradients.orange       // Orange gradient
AppGradients.purple       // Purple gradient
AppGradients.referral     // Purple → Pink
```

---

## 🔘 Button Components

### 1. PrimaryButton

Gradient button for main CTAs (Sign In, Get Started, Next, etc.)

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/primary_button.dart';
```

**Usage:**
```dart
PrimaryButton(
  onPressed: () {
    // Handle tap
  },
  label: 'Sign In',
  icon: Icons.login,              // Optional
  isLoading: false,               // Shows spinner when true
  fullWidth: true,                // Default: true
  gradient: AppGradients.orange,  // Optional custom gradient
)
```

**Properties:**
- `onPressed`: VoidCallback? (null = disabled)
- `label`: String (required)
- `icon`: IconData? (optional leading icon)
- `isLoading`: bool (shows loading spinner)
- `fullWidth`: bool (stretches to full width)
- `gradient`: Gradient? (custom gradient)

---

### 2. SecondaryButton

Outlined button for secondary actions.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/secondary_button.dart';
```

**Usage:**
```dart
SecondaryButton(
  onPressed: () {},
  label: 'I Already Have an Account',
  icon: Icons.person,  // Optional
  isLoading: false,
  fullWidth: true,
)
```

---

### 3. AppTextButton

Text-only button for tertiary actions (Skip, Forgot Password, View All).

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/app_text_button.dart';
```

**Usage:**
```dart
AppTextButton(
  onPressed: () {},
  label: 'Skip',
  icon: Icons.arrow_forward,  // Optional
  color: AppColors.primary,   // Optional
  fontSize: 14,
  fontWeight: FontWeight.w500,
)
```

---

### 4. SocialLoginButton

Button for social login (Google, Facebook, Apple).

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/social_login_button.dart';
```

**Usage:**
```dart
SocialLoginButton(
  onPressed: () {},
  label: 'Google',
  icon: Icon(Icons.g_mobiledata, color: Colors.red),
  iconSize: 24,
)
```

---

### 5. AppIconButton

Icon-only button for settings, close, etc.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/app_icon_button.dart';
```

**Usage:**
```dart
AppIconButton(
  icon: Icons.settings,
  onPressed: () {},
  size: 24,
  color: AppColors.textPrimary,
  backgroundColor: Colors.transparent,
  padding: 8,
)
```

---

### 6. AppBackButton

Navigation back button with icon and text.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/app_back_button.dart';
```

**Usage:**
```dart
AppBackButton(
  onPressed: () => Navigator.of(context).pop(),
  label: 'Back',  // Default: 'Back'
)
```

---

## 📝 Input Field Components

### 7. TextInputField

Text input with label and optional leading icon.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/inputs/text_input_field.dart';
```

**Usage:**
```dart
final emailController = TextEditingController();

TextInputField(
  controller: emailController,
  label: 'Email',
  hintText: 'your.email@example.com',
  leadingIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  },
  onChanged: (value) {
    // Handle changes
  },
  enabled: true,
)
```

---

### 8. PasswordInputField

Password input with visibility toggle.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/inputs/password_input_field.dart';
```

**Usage:**
```dart
final passwordController = TextEditingController();

PasswordInputField(
  controller: passwordController,
  label: 'Password',
  hintText: 'Enter your password',
  validator: (value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  },
  onChanged: (value) {},
  enabled: true,
)
```

---

### 9. CheckboxWithLabel

Checkbox with clickable text label.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/inputs/checkbox_with_label.dart';
```

**Usage:**
```dart
bool rememberMe = false;

CheckboxWithLabel(
  value: rememberMe,
  onChanged: (value) {
    setState(() {
      rememberMe = value ?? false;
    });
  },
  label: 'Remember me',
)
```

---

## 🔤 Typography Components

### 10. BilingualText

Display text in both English and Hindi.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/typography/bilingual_text.dart';
```

**Usage:**
```dart
BilingualText(
  english: 'Live Interactive Classes',
  hindi: 'लाइव इंटरैक्टिव कक्षाएं',
  englishStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
  hindiStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  spacing: 8,
  alignment: CrossAxisAlignment.center,
)

// Inline version
InlineBilingualText(
  english: 'Music',
  hindi: 'संगीत',
  divider: ' • ',
)
```

---

### 11. BadgeLabel

Status badge (Premium Member, difficulty levels, etc.)

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/typography/badge_label.dart';
```

**Usage:**
```dart
// Generic badge
BadgeLabel(
  label: 'Beginner',
  backgroundColor: AppColors.success.withOpacity(0.1),
  textColor: AppColors.success,
  fontSize: 12,
)

// Predefined badges
PremiumBadge(label: 'Premium Member')
SuccessBadge(label: 'Completed')
ErrorBadge(label: 'Failed')
```

---

### 12. LanguageToggle

Switch between Hindi and English.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/typography/language_toggle.dart';
```

**Usage:**
```dart
String currentLanguage = 'en'; // or 'hi'

LanguageToggle(
  currentLanguage: currentLanguage,
  onLanguageChanged: (newLang) {
    setState(() {
      currentLanguage = newLang;
    });
  },
)

// Simple version (text only)
SimpleLanguageToggle(
  currentLanguage: currentLanguage,
  onLanguageChanged: (newLang) {},
)
```

---

## 📐 Layout Components

### 13. FeatureIconContainer

Large circular gradient icon for feature showcases.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/layout/feature_icon_container.dart';
```

**Usage:**
```dart
FeatureIconContainer(
  icon: Icons.people,
  gradient: AppGradients.purple,
  size: 120,
  iconSize: 60,
  iconColor: Colors.white,
)

// Square version
FeatureIconSquare(
  icon: Icons.music_note,
  gradient: AppGradients.blueFeature,
  size: 80,
  borderRadius: 20,
)
```

---

### 14. DividerWithText

Horizontal divider with centered text ("OR CONTINUE WITH").

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/layout/divider_with_text.dart';
```

**Usage:**
```dart
DividerWithText(
  text: 'OR CONTINUE WITH',
  color: AppColors.border,
  thickness: 1,
  spacing: 16,
)
```

---

### 15. SectionHeader

Section title with optional action link.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/layout/section_header.dart';
```

**Usage:**
```dart
SectionHeader(
  title: 'My Courses',
  actionLabel: 'View All',
  onActionTap: () {
    // Navigate to all courses
  },
  titleStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  padding: EdgeInsets.symmetric(vertical: 16),
)
```

---

### 16. AvatarWithBadge

Profile picture with badge overlay.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/layout/avatar_with_badge.dart';
```

**Usage:**
```dart
AvatarWithBadge(
  imageUrl: 'https://example.com/avatar.jpg',
  radius: 40,
  badgeIcon: Icons.edit,
  badgeColor: AppColors.accent,
  onBadgeTap: () {
    // Open edit profile
  },
  borderColor: AppColors.primary,
  borderWidth: 2,
)

// Simple avatar without badge
AppAvatar(
  imageUrl: 'https://example.com/avatar.jpg',
  radius: 24,
  placeholderIcon: Icons.person,
)
```

---

## 🃏 Card Components

### 17. ProfileCard

User profile card with stats.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/cards/profile_card.dart';
```

**Usage:**
```dart
ProfileCard(
  name: 'Priya Sharma',
  email: 'priya@example.com',
  imageUrl: 'https://example.com/avatar.jpg',
  isPremium: true,
  enrolledCount: 2,
  completedCount: 0,
  certificatesCount: 1,
  onEditTap: () {
    // Edit profile
  },
)
```

---

### 18. ReferralCard

Referral points card with invite CTA.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/cards/referral_card.dart';
```

**Usage:**
```dart
ReferralCard(
  points: 150,
  onInviteTap: () {
    // Open invite flow
  },
  title: 'Referral Points',
  description: 'Refer friends to earn points and unlock rewards',
)
```

---

### 19. CourseCard

Course listing card with progress.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/cards/course_card.dart';
```

**Usage:**
```dart
CourseCard(
  title: 'Classical Hindustani Vocal - Beginner',
  instructor: 'Pandit Ravi Kumar',
  thumbnailUrl: 'https://example.com/course.jpg',
  rating: 4.8,
  price: '₹4999',
  progress: 0.35,  // 35% complete (optional)
  onTap: () {
    // Navigate to course details
  },
)
```

---

### 20. SelectableOptionCard

Selectable option for onboarding (interests, etc.)

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/cards/selectable_option_card.dart';
```

**Usage:**
```dart
SelectableOptionCard(
  label: 'Music',
  isSelected: selectedInterests.contains('music'),
  onTap: () {
    setState(() {
      if (selectedInterests.contains('music')) {
        selectedInterests.remove('music');
      } else {
        selectedInterests.add('music');
      }
    });
  },
  emoji: '🎵',  // Use emoji or icon
  // OR
  icon: Icons.music_note,
)
```

---

### 21. StatsRow

Display multiple statistics in a row.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/cards/stats_row.dart';
```

**Usage:**
```dart
StatsRow(
  stats: [
    StatItem(
      value: 2,
      label: 'Enrolled',
      color: AppColors.textPrimary,
    ),
    StatItem(
      value: 0,
      label: 'Completed',
      color: AppColors.success,
    ),
    StatItem(
      value: 1,
      label: 'Certificates',
      color: AppColors.accent,
    ),
  ],
)
```

---

## 🧭 Navigation Components

### 22. BottomNavBar

Bottom navigation with 5 tabs.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/navigation/bottom_nav_bar.dart';
```

**Usage:**
```dart
int currentIndex = 0;

BottomNavBar(
  currentIndex: currentIndex,
  onTap: (index) {
    setState(() {
      currentIndex = index;
    });
  },
  items: [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.book, label: 'Courses'),
    BottomNavItem(icon: Icons.chat, label: 'Community'),
    BottomNavItem(icon: Icons.assignment, label: 'Tests'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
  ],
)
```

---

### 23. AppHeader

Simple header with title and action button.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/navigation/app_header.dart';
```

**Usage:**
```dart
AppHeader(
  title: 'JanJeevan',
  subtitle: 'जनजीवन',
  actionIcon: Icons.language,
  onActionTap: () {
    // Toggle language
  },
  backgroundColor: AppColors.surface,
)
```

---

### 24. GradientHeader

Header with gradient background (Profile screen).

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/navigation/gradient_header.dart';
```

**Usage:**
```dart
GradientHeader(
  title: 'Profile',
  subtitle: 'Manage your account',
  actionIcon: Icons.settings,
  onActionTap: () {},
  gradient: AppGradients.orange,
)
```

---

## 📊 Progress & Indicator Components

### 25. ProgressBar

Linear progress bar with optional percentage.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/progress/progress_bar.dart';
```

**Usage:**
```dart
ProgressBar(
  progress: 0.35,  // 0.0 to 1.0
  height: 8,
  backgroundColor: AppColors.progressBackground,
  progressColor: AppColors.progressFill,
  showPercentage: true,
  borderRadius: 4,
)

// With label
LabeledProgressBar(
  progress: 0.35,
  label: 'Course Progress',
  height: 8,
)
```

---

### 26. CarouselDots

Page indicator dots for intro/onboarding.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/progress/carousel_dots.dart';
```

**Usage:**
```dart
CarouselDots(
  totalDots: 4,
  currentIndex: 1,
  activeColor: AppColors.progressFill,
  inactiveColor: AppColors.progressBackground,
  dotSize: 8,
  spacing: 8,
)
```

---

### 27. StepIndicator

Step progress indicator ("Step X of Y").

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/progress/step_indicator.dart';
```

**Usage:**
```dart
StepIndicator(
  currentStep: 1,
  totalSteps: 4,
  showLabel: true,
)
```

---

### 28. StarRating

Star rating display for courses.

**Import:**
```dart
import 'package:vidyaras_app/src/shared/presentation/components/progress/star_rating.dart';
```

**Usage:**
```dart
// Display only
StarRating(
  rating: 4.8,
  size: 16,
  showNumber: true,
  numberStyle: TextStyle(fontSize: 14),
)

// Interactive (for user input)
InteractiveStarRating(
  rating: userRating,
  onRatingChanged: (newRating) {
    setState(() {
      userRating = newRating;
    });
  },
  maxRating: 5,
  size: 32,
)
```

---

## 🏗️ Architecture Compliance

### Component Location Rules

**✅ CORRECT - Components in Presentation Layer:**
```
lib/src/shared/presentation/components/
```

**❌ INCORRECT - Do NOT place components here:**
```
lib/src/shared/application/     # NO UI components here
lib/src/shared/domain/          # NO UI components here
lib/src/shared/data/            # NO UI components here
```

### Using Components in Features

When building feature screens, import from shared components:

```dart
// lib/src/features/auth/1_presentation/screens/login_screen.dart
import 'package:vidyaras_app/src/shared/presentation/components/buttons/primary_button.dart';
import 'package:vidyaras_app/src/shared/presentation/components/inputs/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextInputField(
            controller: emailController,
            label: 'Email',
            leadingIcon: Icons.email,
          ),
          PrimaryButton(
            onPressed: () {},
            label: 'Sign In',
          ),
        ],
      ),
    );
  }
}
```

---

## 📋 Best Practices

### 1. Always Use Theme Colors

**✅ DO:**
```dart
color: AppColors.primary
```

**❌ DON'T:**
```dart
color: Color(0xFF6366F1)  // Hardcoded color
```

### 2. Use Gradients Consistently

**✅ DO:**
```dart
gradient: AppGradients.primary
```

**❌ DON'T:**
```dart
gradient: LinearGradient(colors: [...])  // Custom gradient
```

### 3. Follow Bilingual Pattern

All user-facing text should support Hindi + English:

**✅ DO:**
```dart
BilingualText(
  english: 'Welcome',
  hindi: 'स्वागत',
)
```

**❌ DON'T:**
```dart
Text('Welcome')  // English only
```

### 4. Component Reusability

If you find yourself copying component code, extract it into a new shared component.

### 5. State Management

Components are stateless where possible. Use Riverpod providers for state:

```dart
// ❌ DON'T create stateful components for business logic
class MyStatefulButton extends StatefulWidget { ... }

// ✅ DO use Riverpod for state
@riverpod
class AuthNotifier extends _$AuthNotifier {
  // Business logic here
}
```

---

## 🚨 Common Mistakes to Avoid

### 1. Business Logic in Components

**❌ WRONG:**
```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // ❌ API calls or business logic here
        await authService.login();
      },
      label: 'Login',
    );
  }
}
```

**✅ CORRECT:**
```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryButton(
      onPressed: () {
        // ✅ Delegate to Application Layer
        ref.read(authNotifierProvider.notifier).login();
      },
      label: 'Login',
    );
  }
}
```

### 2. Hardcoded Strings

**❌ WRONG:**
```dart
PrimaryButton(label: 'Sign In')
```

**✅ CORRECT:**
```dart
PrimaryButton(
  label: AppLocalizations.of(context)!.signIn,
)
```

### 3. Inline Styles

**❌ WRONG:**
```dart
TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Color(0xFF1F2937),
)
```

**✅ CORRECT:**
```dart
Theme.of(context).textTheme.titleLarge
// OR
TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: AppColors.textPrimary,
)
```

---

## 📦 Complete Example: Login Screen

```dart
import 'package:flutter/material.dart';
import 'package:vidyaras_app/src/shared/presentation/components/buttons/primary_button.dart';
import 'package:vidyaras_app/src/shared/presentation/components/buttons/secondary_button.dart';
import 'package:vidyaras_app/src/shared/presentation/components/buttons/social_login_button.dart';
import 'package:vidyaras_app/src/shared/presentation/components/buttons/app_back_button.dart';
import 'package:vidyaras_app/src/shared/presentation/components/buttons/app_text_button.dart';
import 'package:vidyaras_app/src/shared/presentation/components/inputs/text_input_field.dart';
import 'package:vidyaras_app/src/shared/presentation/components/inputs/password_input_field.dart';
import 'package:vidyaras_app/src/shared/presentation/components/inputs/checkbox_with_label.dart';
import 'package:vidyaras_app/src/shared/presentation/components/layout/divider_with_text.dart';
import 'package:vidyaras_app/src/shared/presentation/components/layout/feature_icon_container.dart';
import 'package:vidyaras_app/src/shared/presentation/components/typography/bilingual_text.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),
              const SizedBox(height: 40),

              // Feature icon
              Center(
                child: FeatureIconSquare(
                  icon: Icons.music_note,
                  size: 80,
                  borderRadius: 20,
                ),
              ),
              const SizedBox(height: 32),

              // Title
              const Center(
                child: BilingualText(
                  english: 'Welcome Back!',
                  hindi: 'वापसी पर स्वागत है!',
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Sign in to continue your learning journey',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // Email field
              TextInputField(
                controller: _emailController,
                label: 'Email',
                hintText: 'your.email@example.com',
                leadingIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password field
              PasswordInputField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter your password',
              ),
              const SizedBox(height: 16),

              // Remember me & Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckboxWithLabel(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    label: 'Remember me',
                  ),
                  AppTextButton(
                    onPressed: () {},
                    label: 'Forgot Password?',
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Sign in button
              PrimaryButton(
                onPressed: () {},
                label: 'Sign In',
              ),
              const SizedBox(height: 24),

              // Divider
              const DividerWithText(text: 'OR CONTINUE WITH'),
              const SizedBox(height: 24),

              // Social login buttons
              Row(
                children: [
                  Expanded(
                    child: SocialLoginButton(
                      onPressed: () {},
                      label: 'Google',
                      icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SocialLoginButton(
                      onPressed: () {},
                      label: 'Facebook',
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Sign up link
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppTextButton(
                      onPressed: () {},
                      label: 'Sign Up',
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🎯 Summary

- **28 components** ready to use
- **Bilingual support** built-in
- **Theme-driven** design system
- **Architecture compliant** - all in Presentation Layer
- **No business logic** in components
- **Reusable and composable**

For questions or issues, refer to the architecture documentation in `docs/architecture.md` and `docs/rules.md`.
