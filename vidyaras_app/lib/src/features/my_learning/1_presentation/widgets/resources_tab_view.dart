import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../3_domain/models/course_material.dart';

/// Tab view widget displaying course resources/materials (PDFs, docs, etc.).
/// Used within the CourseContentScreen's TabBarView.
class ResourcesTabView extends StatelessWidget {
  const ResourcesTabView({
    super.key,
    required this.materials,
    this.onMaterialTap,
    this.onDownloadTap,
  });

  /// List of course materials to display
  final List<CourseMaterial> materials;

  /// Callback when a material item is tapped
  final void Function(CourseMaterial)? onMaterialTap;

  /// Callback when download button is tapped
  final void Function(CourseMaterial)? onDownloadTap;

  @override
  Widget build(BuildContext context) {
    if (materials.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: materials.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildHeader();
        }
        final material = materials[index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _buildMaterialCard(material),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Course Resources',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${materials.length} file${materials.length != 1 ? 's' : ''} available',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () {
              // Download all functionality
            },
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const Text('All'),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(CourseMaterial material) {
    final isPdf = material.type == 'pdf' || material.fileUrl.endsWith('.pdf');
    final isDoc = material.type == 'doc' || material.fileUrl.endsWith('.doc');
    final isVideo = material.type == 'video';

    Color typeColor;
    IconData typeIcon;

    if (isPdf) {
      typeColor = Colors.red;
      typeIcon = Icons.picture_as_pdf_rounded;
    } else if (isDoc) {
      typeColor = Colors.blue;
      typeIcon = Icons.description_rounded;
    } else if (isVideo) {
      typeColor = Colors.purple;
      typeIcon = Icons.video_library_rounded;
    } else {
      typeColor = Colors.grey;
      typeIcon = Icons.insert_drive_file_rounded;
    }

    return InkWell(
      onTap: onMaterialTap != null ? () => onMaterialTap!(material) : null,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Type Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(typeIcon, color: typeColor, size: 24),
            ),
            const SizedBox(width: AppSpacing.md),

            // Title & Size
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        material.fileExtension,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: typeColor,
                        ),
                      ),
                      if (material.formattedSize.isNotEmpty) ...[
                        Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          material.formattedSize,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Download Button
            IconButton(
              onPressed: onDownloadTap != null
                  ? () => onDownloadTap!(material)
                  : null,
              icon: const Icon(Icons.download_rounded),
              color: AppColors.textSecondary,
              tooltip: 'Download',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_open_rounded,
              size: 64,
              color: AppColors.helperText,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'No Resources Available',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Course materials will be added by the instructor',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
