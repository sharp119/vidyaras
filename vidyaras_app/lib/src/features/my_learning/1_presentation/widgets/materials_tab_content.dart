import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../../3_domain/models/course_material.dart';

/// Tab content showing course materials (PDFs, docs, etc.)
/// Displays downloadable resources organized by type or section
class MaterialsTabContent extends ConsumerWidget {
  const MaterialsTabContent({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsAsync = ref.watch(
      courseMaterialsProvider(courseId: courseId),
    );

    return materialsAsync.when(
      data: (materials) {
        if (materials.isEmpty) {
          return _EmptyState();
        }

        // Group materials by section (if section is null, use "General")
        // Use course modules for section titles if available
        // Note: For now we group by moduleId itself or 'General'
        // In the future we might want to pass formatted module titles
        final Map<String, List<CourseMaterial>> materialsByModule = {};
        for (final material in materials) {
          final module = material.moduleId ?? 'General';
          if (!materialsByModule.containsKey(module)) {
            materialsByModule[module] = [];
          }
          materialsByModule[module]!.add(material);
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.folder_open,
                      size: 24,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Course Materials',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${materials.length} files available for download',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Materials by Section
            ...materialsByModule.entries.map((entry) {
              final sectionName = entry.key;
              final sectionMaterials = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Row(
                      children: [
                        Icon(Icons.folder, size: 18, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          sectionName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            sectionMaterials.length.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Material Items
                    ...sectionMaterials.map(
                      (material) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _MaterialItem(material: material),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 40),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          Center(child: Text('Error: ${error.toString()}')),
    );
  }
}

class _MaterialItem extends StatelessWidget {
  const _MaterialItem({required this.material});

  final CourseMaterial material;

  Future<void> _downloadFile() async {
    final uri = Uri.parse(material.fileUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'pdf':
        return Colors.red;
      case 'doc':
        return Colors.blue;
      case 'video':
        return Colors.purple;
      case 'image':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
        return Icons.description;
      case 'video':
        return Icons.video_file;
      case 'image':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(material.type);

    return InkWell(
      onTap: _downloadFile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceLight, width: 1),
        ),
        child: Row(
          children: [
            // File Type Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getTypeIcon(material.type),
                size: 24,
                color: typeColor,
              ),
            ),

            const SizedBox(width: 16),

            // File Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          material.fileExtension,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: typeColor,
                          ),
                        ),
                      ),
                      if (material.formattedSize.isNotEmpty) ...[
                        const SizedBox(width: 8),
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

            const SizedBox(width: 12),

            // Download Button
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.download, size: 20, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            const Text(
              'No Materials Available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Course materials will be added by the instructor',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
