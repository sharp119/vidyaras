import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import 'available_test_card.dart';
import '../../3_domain/models/test.dart';

/// Widget that displays a locked state for the My Courses tab
/// with a blurred background of available quizzes
class LockedTabPlaceholder extends StatelessWidget {
  const LockedTabPlaceholder({
    super.key,
    required this.availableTests,
    required this.onExplorePressed,
  });

  final List<Test> availableTests;
  final VoidCallback onExplorePressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        // Layer 1: Faded Background Quizzes
        _buildFadedBackground(context),

        // Layer 2: Blurring Overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: AppColors.background.withOpacity(0.80),
            ),
          ),
        ),

        // Layer 3: Centered Content
        _buildContent(context, textTheme),
      ],
    );
  }

  Widget _buildFadedBackground(BuildContext context) {
    // Show only first 3 available quizzes in the background
    final backgroundTests = availableTests.take(3).toList();

    if (backgroundTests.isEmpty) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: Opacity(
        opacity: 0.3,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: backgroundTests.map((test) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AvailableTestCard(
                title: test.title,
                description: test.titleHindi,
                category: test.category,
                difficulty: test.difficulty,
                questionCount: test.questionCount,
                durationMinutes: test.durationMinutes,
                onTap: () {}, // No-op, it's just for visual effect
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TextTheme textTheme) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 24.0 : 32.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lock Icon
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.5),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.border.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                size: isSmallScreen ? 56 : 64,
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: isSmallScreen ? 24 : 32),

            // Headline
            Text(
              'Your Course Quizzes Live Here',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontSize: isSmallScreen ? 20 : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Body Text
            Text(
              'This tab is for quizzes from your enrolled courses. Once you enroll, all your practice tests will appear here, ready for you!',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
                fontSize: isSmallScreen ? 14 : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: isSmallScreen ? 24 : 32),

            // CTA Button
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: onExplorePressed,
                label: 'Explore All Courses',
                fullWidth: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
