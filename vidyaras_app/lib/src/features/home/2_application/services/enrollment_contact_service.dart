import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../3_domain/models/enrollment_message_data.dart';
import '../../../../shared/constants/contact_config.dart';

/// Service to handle enrollment contact methods
/// Uses native share sheet for sharing to any app
/// Uses url_launcher for direct phone calls
class EnrollmentContactService {
  /// Open native share sheet with enrollment message
  /// User can choose WhatsApp, Email, SMS, or any other app
  Future<bool> shareEnrollmentMessage(EnrollmentMessageData data) async {
    try {
      final message = data.toShareMessage();

      final result = await Share.share(
        message,
        subject: 'VidyaRas - Enrollment Request for ${data.courseTitle}',
      );

      // Share was successful if result status is not dismissed
      return result.status != ShareResultStatus.dismissed;
    } catch (e) {
      print('Error sharing: $e');
      return false;
    }
  }

  /// Make phone call to VidyaRas support
  Future<bool> makePhoneCall() async {
    try {
      final url = Uri.parse('tel:${ContactConfig.phoneNumber}');

      if (await canLaunchUrl(url)) {
        return await launchUrl(url);
      }
      return false;
    } catch (e) {
      print('Error making phone call: $e');
      return false;
    }
  }
}
