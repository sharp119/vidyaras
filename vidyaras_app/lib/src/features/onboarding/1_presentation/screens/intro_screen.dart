import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/components/buttons/app_text_button.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../../../shared/presentation/components/progress/carousel_dots.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../models/intro_content.dart';
import '../widgets/intro_page.dart';

/// Main intro/onboarding screen with PageView
/// Design System: Theme-based typography, proper spacing
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define the 4 intro content pages
  final List<IntroContent> _introPages = const [
    IntroContent(
      titleEnglish: 'Traditional Arts & Wellness',
      titleHindi: 'पारंपरिक कला और स्वास्थ्य',
      descriptionEnglish:
          'Learn authentic Indian arts, music, and wellness practices from expert teachers',
      descriptionHindi:
          'विशेषज्ञ शिक्षकों से प्रामाणिक भारतीय कला, संगीत और स्वास्थ्य प्रथाओं को सीखें',
      icon: Icons.auto_awesome,
      gradient: AppGradients.blueFeature,
    ),
    IntroContent(
      titleEnglish: 'Live Interactive Classes',
      titleHindi: 'लाइव इंटरैक्टिव कक्षाएं',
      descriptionEnglish:
          'Join live batches with personalized feedback and community support',
      descriptionHindi:
          'व्यक्तिगत प्रतिक्रिया और समुदाय समर्थन के साथ लाइव बैचों में शामिल हों',
      icon: Icons.people,
      gradient: AppGradients.purple,
    ),
    IntroContent(
      titleEnglish: 'Structured Learning Path',
      titleHindi: 'संरचित सीखने का मार्ग',
      descriptionEnglish:
          'Follow a step-by-step curriculum designed for all skill levels',
      descriptionHindi:
          'सभी कौशल स्तरों के लिए डिज़ाइन किए गए चरण-दर-चरण पाठ्यक्रम का पालन करें',
      icon: Icons.school,
      gradient: AppGradients.referral,
    ),
    IntroContent(
      titleEnglish: 'Personalized Learning',
      titleHindi: 'व्यक्तिगत शिक्षा',
      descriptionEnglish:
          'AI-powered recommendations based on your interests and goals',
      descriptionHindi:
          'आपकी रुचियों और लक्ष्यों के आधार पर AI-संचालित सिफारिशें',
      icon: Icons.stars,
      gradient: AppGradients.orangeFeature,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _introPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart,
      );
    }
  }

  void _skipIntro() {
    context.go('/login');
  }

  void _getStarted() {
    context.go('/login');
  }

  void _goToLogin() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isLastPage = _currentPage == _introPages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Gradient Mesh (Subtle)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color(0xFFFAFAFA)],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top bar with Skip button (hidden on last page)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.mdLg,
                    vertical: AppSpacing.md,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedOpacity(
                        opacity: isLastPage ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: IgnorePointer(
                          ignoring: isLastPage,
                          child: AppTextButton(
                            onPressed: _skipIntro,
                            label: 'Skip',
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // PageView with intro pages
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _introPages.length,
                    itemBuilder: (context, index) {
                      return IntroPage(content: _introPages[index]);
                    },
                  ),
                ),

                // Carousel dots indicator
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: CarouselDots(
                    totalDots: _introPages.length,
                    currentIndex: _currentPage,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.primary.withOpacity(0.2),
                    dotSize: 8,
                    spacing: 8,
                  ),
                ),

                // Bottom buttons
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.mdLg,
                    0,
                    AppSpacing.mdLg,
                    48,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                    child: isLastPage
                        ? Column(
                            key: const ValueKey('last_page_buttons'),
                            children: [
                              PrimaryButton(
                                onPressed: _getStarted,
                                label: 'Get Started',
                                fullWidth: true,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              SecondaryButton(
                                onPressed: _goToLogin,
                                label: 'I Already Have an Account',
                                fullWidth: true,
                              ),
                            ],
                          )
                        : SizedBox(
                            width: double.infinity,
                            key: const ValueKey('next_button'),
                            child: PrimaryButton(
                              onPressed: _nextPage,
                              label: 'Next',
                              fullWidth: true,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
