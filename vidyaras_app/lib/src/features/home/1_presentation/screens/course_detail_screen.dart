import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../2_application/providers/home_providers.dart';
import '../../3_domain/models/course_detail.dart';
import '../widgets/course_stats_card.dart';
import '../widgets/curriculum_section_card.dart';
import '../widgets/batch_info_card.dart';
import '../widgets/pricing_card.dart';
import '../widgets/course_review_card.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';

/// Course detail screen showing comprehensive course information
/// Displays curriculum, pricing, reviews, and enrollment options
class CourseDetailScreen extends ConsumerStatefulWidget {
  const CourseDetailScreen({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  ConsumerState<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _selectedFullPayment = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailAsync = ref.watch(courseDetailProvider(widget.courseId));

    return Scaffold(
      body: SafeArea(
        top: false, // Allow content to go under status bar
        bottom: true, // Respect bottom system UI
        child: courseDetailAsync.when(
          data: (courseDetail) => _buildContent(context, courseDetail),
          loading: () => _buildLoading(),
          error: (error, stack) => _buildError(error),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CourseDetail courseDetail) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.0549;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

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
                const SizedBox(height: 16),

                // Tags Section
                _buildTagsSection(courseDetail),
                const SizedBox(height: 16),

                // Description
                _buildDescriptionSection(courseDetail),
                const SizedBox(height: 24),

                // Stats Cards
                _buildStatsSection(courseDetail),
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

                // Pricing Section
                if (!courseDetail.pricing.isFree) ...[
                  _buildPricingSection(courseDetail),
                  const SizedBox(height: 24),
                ],

                // CTA Button
                _buildCTAButton(courseDetail),

                // Bottom padding respecting system UI
                SizedBox(height: bottomPadding > 0 ? bottomPadding + 16 : 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroHeader(CourseDetail courseDetail) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 14, top: 16),
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: courseDetail.basicInfo.isLive
                  ? const Color(0xFFEF4444)
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              courseDetail.basicInfo.isLive ? 'LIVE CLASSES' : 'RECORDED COURSE',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (courseDetail.basicInfo.thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: courseDetail.basicInfo.thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.surfaceLight,
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surfaceLight,
                  child: const Icon(Icons.image_not_supported, size: 48),
                ),
              )
            else
              Container(color: AppColors.surfaceLight),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
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
        Text(
          courseDetail.basicInfo.title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          courseDetail.basicInfo.instructor,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.star, color: Color(0xFFFBBF24), size: 18),
            const SizedBox(width: 4),
            Text(
              courseDetail.basicInfo.rating.toStringAsFixed(1),
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              '(${courseDetail.basicInfo.reviewCount})',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.person_outline,
                color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 4),
            Text(
              '${courseDetail.basicInfo.enrolledCount} students',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagsSection(CourseDetail courseDetail) {
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (courseDetail.basicInfo.isLive || courseDetail.basicInfo.isRecorded)
          Chip(
            label: Text(
              courseDetail.basicInfo.isLive ? 'Live Classes' : 'Recorded',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            backgroundColor: AppColors.surfaceLight,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        if (courseDetail.language != null)
          Chip(
            label: Text(
              'Bilingual',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            backgroundColor: AppColors.surfaceLight,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        if (courseDetail.hasCertificate)
          Chip(
            avatar: const Icon(
              Icons.workspace_premium_outlined,
              size: 12,
              color: AppColors.accentDark,
            ),
            label: Text(
              'Certificate',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.accentDark,
              ),
            ),
            backgroundColor: AppColors.accent.withOpacity(0.1),
            padding: const EdgeInsets.only(left: 6, right: 8, top: 3, bottom: 3),
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
      ],
    );
  }

  Widget _buildDescriptionSection(CourseDetail courseDetail) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      courseDetail.description,
      style: textTheme.bodyLarge?.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildStatsSection(CourseDetail courseDetail) {
    return Row(
      children: [
        Expanded(
          child: CourseStatsCard(
            icon: Icons.timer_outlined,
            value: courseDetail.basicInfo.duration ?? 'N/A',
            label: 'Duration',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CourseStatsCard(
            icon: courseDetail.basicInfo.isLive
                ? Icons.calendar_today_outlined
                : Icons.schedule_outlined,
            value: courseDetail.basicInfo.isLive
                ? (courseDetail.liveBatch?.schedule ?? 'See batch')
                : (courseDetail.accessDays != null
                    ? '${courseDetail.accessDays} days'
                    : 'Lifetime'),
            label: courseDetail.basicInfo.isLive ? 'Schedule' : 'Access',
          ),
        ),
      ],
    );
  }

  Widget _buildTabsSection(CourseDetail courseDetail) {
    return Column(
      children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            indicatorPadding: const EdgeInsets.all(4),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Curriculum'),
              Tab(text: 'Reviews'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(courseDetail),
              _buildCurriculumTab(courseDetail),
              _buildReviewsTab(courseDetail),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(CourseDetail courseDetail) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What You\'ll Learn',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...courseDetail.whatYouLearn.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 18, color: AppColors.success),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          Text(
            'Course Includes',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...courseDetail.courseIncludes.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        item,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          Text(
            'Prerequisites',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...courseDetail.prerequisites.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        item,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCurriculumTab(CourseDetail courseDetail) {
    return ListView.separated(
      itemCount: courseDetail.curriculum.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        return CurriculumSectionCard(
          section: courseDetail.curriculum[index],
          sectionNumber: index,
        );
      },
    );
  }

  Widget _buildReviewsTab(CourseDetail courseDetail) {
    if (courseDetail.reviews.isEmpty) {
      return Center(
        child: Text(
          'No reviews yet',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      );
    }

    return ListView.separated(
      itemCount: courseDetail.reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return CourseReviewCard(review: courseDetail.reviews[index]);
      },
    );
  }

  Widget _buildPricingSection(CourseDetail courseDetail) {
    return Row(
      children: [
        Expanded(
          child: PricingCard(
            title: 'Pay Full',
            price: courseDetail.pricing.fullPrice,
            isSelected: _selectedFullPayment,
            onTap: () => setState(() => _selectedFullPayment = true),
          ),
        ),
        if (courseDetail.pricing.emiMonthlyPrice != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: PricingCard(
              title: 'Monthly EMI',
              price: courseDetail.pricing.emiMonthlyPrice!,
              subtitle: '/mo',
              isSelected: !_selectedFullPayment,
              onTap: () => setState(() => _selectedFullPayment = false),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCTAButton(CourseDetail courseDetail) {
    if (courseDetail.pricing.isFree) {
      return PrimaryButton(
        label: 'Enroll Now (Free)',
        onPressed: () {
          // TODO: Handle free enrollment
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enrollment feature coming soon!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        fullWidth: true,
      );
    }

    return PrimaryButton(
      label: 'Contact Us to Enroll',
      onPressed: () => _launchWhatsApp(courseDetail),
      fullWidth: true,
    );
  }

  Future<void> _launchWhatsApp(CourseDetail courseDetail) async {
    final selectedPrice = _selectedFullPayment
        ? '₹${courseDetail.pricing.fullPrice}'
        : '₹${courseDetail.pricing.emiMonthlyPrice}/mo (${courseDetail.pricing.emiTenure} months)';

    final message = '''
Hello VidyaRas Team!

I'm interested in enrolling in:
📚 *${courseDetail.basicInfo.title}*
👨‍🏫 Instructor: ${courseDetail.basicInfo.instructor}
💰 Price: $selectedPrice

Please share enrollment details.
    ''';

    final whatsappUrl =
        'https://wa.me/91XXXXXXXXXX?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open WhatsApp. Please try again.'),
          ),
        );
      }
    }
  }

  Widget _buildLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
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
