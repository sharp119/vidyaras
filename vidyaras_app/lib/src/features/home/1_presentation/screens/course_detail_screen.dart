import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../2_application/providers/home_providers.dart';
import '../../3_domain/models/course_detail.dart';
import '../../3_domain/models/enrollment_message_data.dart';
import '../widgets/curriculum_section_card.dart';
import '../widgets/batch_info_card.dart';
import '../widgets/enrollment_options_bottom_sheet.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../../auth/3_domain/models/app_user.dart' as domain;

/// Course detail screen showing comprehensive course information
/// Displays curriculum, pricing, reviews, and enrollment options
class CourseDetailScreen extends ConsumerStatefulWidget {
  const CourseDetailScreen({super.key, required this.courseId});

  final String courseId;

  @override
  ConsumerState<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen> {
  bool _selectedFullPayment = false; // Default to EMI

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailAsync = ref.watch(courseDetailProvider(widget.courseId));

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: courseDetailAsync.when(
          data: (courseDetail) => Stack(
            children: [
              // Scrollable content
              _buildContent(context, courseDetail),

              // Fixed bottom pricing section
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildFixedBottomSection(courseDetail),
              ),
            ],
          ),
          loading: () => _buildLoading(),
          error: (error, stack) => _buildError(error),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CourseDetail courseDetail) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.0549;

    return CustomScrollView(
      slivers: [
        // Hero Header with Course Image
        _buildHeroHeader(courseDetail),

        // Main Content
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Course Info Section
                _buildCourseInfoSection(courseDetail),
                const SizedBox(height: 24),

                // Description
                _buildDescriptionSection(courseDetail),
                const SizedBox(height: 24),

                // Tabs Section
                _buildTabsSection(courseDetail),
                const SizedBox(height: 24),

                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 24),

                // Live Batch Info (only for live courses)
                if (courseDetail.liveBatch != null) ...[
                  BatchInfoCard(batchInfo: courseDetail.liveBatch!),
                  const SizedBox(height: 24),
                ],

                // Bottom padding for fixed section (pricing + button ~200px)
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroHeader(CourseDetail courseDetail) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary, // Orange when collapsed
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (courseDetail.basicInfo.thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: courseDetail.basicInfo.thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: AppColors.surfaceLight),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surfaceLight,
                  child: const Icon(Icons.image_not_supported, size: 48),
                ),
              )
            else
              Container(color: AppColors.surfaceLight),
          ],
        ),
        stretchModes: const [StretchMode.zoomBackground],
      ),
    );
  }

  Widget _buildCourseInfoSection(CourseDetail courseDetail) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges row at top
        Row(
          children: [
            if (courseDetail.basicInfo.isLive ||
                courseDetail.basicInfo.isRecorded)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: courseDetail.basicInfo.isLive
                      ? AppColors.error
                      : AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  courseDetail.basicInfo.isLive ? 'LIVE' : 'RECORDED',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'BESTSELLER',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Course title
        Text(
          courseDetail.basicInfo.title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 26,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 18),

        // Instructor row with avatar and rating
        Row(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 31,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseDetail.basicInfo.instructor,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFBBF24),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        courseDetail.basicInfo.rating.toStringAsFixed(1),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${courseDetail.basicInfo.reviewCount} REVIEWS',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        // Stats row (Duration, Lessons, Level)
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: Icons.access_time,
                label: 'DURATION',
                value: courseDetail.basicInfo.duration ?? '12 Hours',
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              _StatItem(
                icon: Icons.videocam_outlined,
                label: 'LESSONS',
                value:
                    '${courseDetail.curriculum.length * 5}', // Approximate based on sections
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              _StatItem(
                icon: Icons.signal_cellular_alt,
                label: 'LEVEL',
                value: 'Beginner',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _StatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.textSecondary),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(CourseDetail courseDetail) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Course',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          courseDetail.description,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildTabsSection(CourseDetail courseDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Syllabus',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...courseDetail.curriculum.asMap().entries.map((entry) {
          final index = entry.key;
          final section = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CurriculumSectionCard(
              section: section,
              sectionNumber: index,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFixedBottomSection(CourseDetail courseDetail) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: bottomPadding > 0 ? bottomPadding + 16 : 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Payment mode selector
          if (!courseDetail.pricing.isFree) ...[
            Row(
              children: [
                Expanded(
                  child: _buildPaymentModeOption(
                    title: 'Pay Full',
                    price: '₹${courseDetail.pricing.fullPrice}',
                    isSelected: _selectedFullPayment,
                    onTap: () => setState(() => _selectedFullPayment = true),
                  ),
                ),
                const SizedBox(width: 12),
                if (courseDetail.pricing.emiMonthlyPrice != null)
                  Expanded(
                    child: _buildPaymentModeOption(
                      title: 'Monthly EMI',
                      price: '₹${courseDetail.pricing.emiMonthlyPrice}/mo',
                      isSelected: !_selectedFullPayment,
                      onTap: () => setState(() => _selectedFullPayment = false),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Enroll button
          SizedBox(
            width: double.infinity,
            height: 57,
            child: ElevatedButton(
              onPressed: () => _showEnrollmentOptions(courseDetail),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                courseDetail.pricing.isFree
                    ? 'Enroll Now (Free)'
                    : 'Contact Us to Enroll',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentModeOption({
    required String title,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : AppColors.surfaceLight,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnrollmentOptions(CourseDetail courseDetail) async {
    // Get current user data
    final currentUserAsync = ref.read(currentUserProvider);

    final user = currentUserAsync.valueOrNull;

    if (user == null) {
      // User not logged in - should not happen but handle gracefully
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please log in to enroll'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    // Build enrollment message data
    final enrollmentData = _buildEnrollmentData(courseDetail, user);

    // Show bottom sheet
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          EnrollmentOptionsBottomSheet(enrollmentData: enrollmentData),
    );
  }

  EnrollmentMessageData _buildEnrollmentData(
    CourseDetail courseDetail,
    domain.AppUser user,
  ) {
    final selectedPrice = _selectedFullPayment
        ? '₹${courseDetail.pricing.fullPrice}'
        : '₹${courseDetail.pricing.emiMonthlyPrice}/mo (${courseDetail.pricing.emiTenure} months)';

    return EnrollmentMessageData(
      // User data
      userName: user.name ?? user.email ?? 'User',
      userPhone: user.phoneNumber ?? '',
      userEmail: user.email ?? '',

      // Course data
      courseTitle: courseDetail.basicInfo.title,
      instructor: courseDetail.basicInfo.instructor,
      courseType: courseDetail.basicInfo.isLive
          ? 'Live Classes'
          : 'Recorded Course',

      // Pricing
      selectedPrice: selectedPrice,
      isFullPayment: _selectedFullPayment,

      // Live batch specific
      batchName: courseDetail.liveBatch?.name,
      batchSchedule: courseDetail.liveBatch?.schedule,
      batchStartDate: courseDetail.liveBatch != null
          ? DateFormat('MMM d, y').format(courseDetail.liveBatch!.startDate)
          : null,

      // Recorded course specific
      accessDays: courseDetail.accessDays,

      // Free course flag
      isFree: courseDetail.pricing.isFree,
    );
  }

  Widget _buildLoading() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _buildError(Object error) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Failed to load course details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
