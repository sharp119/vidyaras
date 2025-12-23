import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/app_text_button.dart';

/// Filter options for courses
class CourseFilters {
  final bool? showFreeOnly;
  final bool? showLiveOnly;
  final bool? showRecordedOnly;
  final double? minRating;
  final String? sortBy;

  const CourseFilters({
    this.showFreeOnly,
    this.showLiveOnly,
    this.showRecordedOnly,
    this.minRating,
    this.sortBy,
  });

  CourseFilters copyWith({
    bool? showFreeOnly,
    bool? showLiveOnly,
    bool? showRecordedOnly,
    double? minRating,
    String? sortBy,
  }) {
    return CourseFilters(
      showFreeOnly: showFreeOnly ?? this.showFreeOnly,
      showLiveOnly: showLiveOnly ?? this.showLiveOnly,
      showRecordedOnly: showRecordedOnly ?? this.showRecordedOnly,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  bool get hasActiveFilters {
    return showFreeOnly == true ||
        showLiveOnly == true ||
        showRecordedOnly == true ||
        minRating != null ||
        sortBy != null;
  }
}

/// Bottom sheet for course filtering
/// Design System: 24dp radius, theme typography
class CourseFiltersBottomSheet extends StatefulWidget {
  const CourseFiltersBottomSheet({
    super.key,
    required this.initialFilters,
    required this.onApply,
  });

  final CourseFilters initialFilters;
  final ValueChanged<CourseFilters> onApply;

  @override
  State<CourseFiltersBottomSheet> createState() =>
      _CourseFiltersBottomSheetState();
}

class _CourseFiltersBottomSheetState extends State<CourseFiltersBottomSheet> {
  late bool showFreeOnly;
  late bool showLiveOnly;
  late bool showRecordedOnly;
  late double? minRating;
  late String? sortBy;

  @override
  void initState() {
    super.initState();
    showFreeOnly = widget.initialFilters.showFreeOnly ?? false;
    showLiveOnly = widget.initialFilters.showLiveOnly ?? false;
    showRecordedOnly = widget.initialFilters.showRecordedOnly ?? false;
    minRating = widget.initialFilters.minRating;
    sortBy = widget.initialFilters.sortBy;
  }

  void _reset() {
    setState(() {
      showFreeOnly = false;
      showLiveOnly = false;
      showRecordedOnly = false;
      minRating = null;
      sortBy = null;
    });
  }

  void _apply() {
    final filters = CourseFilters(
      showFreeOnly: showFreeOnly ? true : null,
      showLiveOnly: showLiveOnly ? true : null,
      showRecordedOnly: showRecordedOnly ? true : null,
      minRating: minRating,
      sortBy: sortBy,
    );
    widget.onApply(filters);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.mdLg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.large + 8),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Courses',
                    style: theme.textTheme.headlineMedium, // H2: 20sp
                  ),
                  AppTextButton(label: 'Reset', onPressed: _reset),
                ],
              ),
              const SizedBox(height: AppSpacing.mdLg),

              // Price Filter
              Text(
                'Price',
                style: theme.textTheme.titleLarge, // 16sp
              ),
              const SizedBox(height: AppSpacing.mdSm),
              _FilterChip(
                label: 'Free Only',
                isSelected: showFreeOnly,
                onTap: () => setState(() => showFreeOnly = !showFreeOnly),
              ),
              const SizedBox(height: AppSpacing.mdLg),

              // Course Type Filter
              Text('Course Type', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.mdSm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _FilterChip(
                    label: 'Live Sessions',
                    isSelected: showLiveOnly,
                    onTap: () => setState(() {
                      showLiveOnly = !showLiveOnly;
                      if (showLiveOnly) showRecordedOnly = false;
                    }),
                  ),
                  _FilterChip(
                    label: 'Recorded',
                    isSelected: showRecordedOnly,
                    onTap: () => setState(() {
                      showRecordedOnly = !showRecordedOnly;
                      if (showRecordedOnly) showLiveOnly = false;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.mdLg),

              // Rating Filter
              Text('Minimum Rating', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.mdSm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _FilterChip(
                    label: '4.5+ ⭐',
                    isSelected: minRating == 4.5,
                    onTap: () => setState(() {
                      minRating = minRating == 4.5 ? null : 4.5;
                    }),
                  ),
                  _FilterChip(
                    label: '4.0+ ⭐',
                    isSelected: minRating == 4.0,
                    onTap: () => setState(() {
                      minRating = minRating == 4.0 ? null : 4.0;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.mdLg),

              // Sort By
              Text('Sort By', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.mdSm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _FilterChip(
                    label: 'Most Popular',
                    isSelected: sortBy == 'popular',
                    onTap: () => setState(() {
                      sortBy = sortBy == 'popular' ? null : 'popular';
                    }),
                  ),
                  _FilterChip(
                    label: 'Highest Rated',
                    isSelected: sortBy == 'rating',
                    onTap: () => setState(() {
                      sortBy = sortBy == 'rating' ? null : 'rating';
                    }),
                  ),
                  _FilterChip(
                    label: 'Price: Low to High',
                    isSelected: sortBy == 'price_low',
                    onTap: () => setState(() {
                      sortBy = sortBy == 'price_low' ? null : 'price_low';
                    }),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Apply Button
              PrimaryButton(label: 'Apply Filters', onPressed: _apply),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
