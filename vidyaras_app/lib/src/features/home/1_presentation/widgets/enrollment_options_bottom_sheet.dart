import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../3_domain/models/contact_method.dart';
import '../../3_domain/models/enrollment_message_data.dart';
import '../../2_application/services/enrollment_contact_service.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import 'contact_option_tile.dart';

/// Bottom sheet showing all contact method options
class EnrollmentOptionsBottomSheet extends ConsumerWidget {
  const EnrollmentOptionsBottomSheet({
    super.key,
    required this.enrollmentData,
  });

  final EnrollmentMessageData enrollmentData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: const [
                Icon(Icons.school_outlined, color: AppColors.primary),
                SizedBox(width: 12),
                Text(
                  'Choose Contact Method',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Contact options
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: ContactMethod.values.map((method) {
              return ContactOptionTile(
                method: method,
                onTap: () => _handleContactMethod(context, ref, method),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _handleContactMethod(
    BuildContext context,
    WidgetRef ref,
    ContactMethod method,
  ) async {
    final service = EnrollmentContactService();
    bool success = false;
    String message = '';

    switch (method) {
      case ContactMethod.share:
        // Close bottom sheet first so share dialog can appear
        Navigator.pop(context);
        success = await service.shareEnrollmentMessage(enrollmentData);
        message = success
            ? 'Shared successfully!'
            : 'Share cancelled';
        break;

      case ContactMethod.phone:
        success = await service.makePhoneCall();
        message = success
            ? 'Opening phone...'
            : 'Could not make call. Please try again.';
        break;
    }

    if (context.mounted) {
      // Close bottom sheet if not already closed
      if (method != ContactMethod.share) {
        Navigator.pop(context);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: success ? AppColors.success : AppColors.error,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
