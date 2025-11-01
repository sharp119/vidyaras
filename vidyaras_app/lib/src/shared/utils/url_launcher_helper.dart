import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper class for launching external URLs, emails, and phone numbers
/// Uses url_launcher package to open links in external browser/apps
class UrlLauncherHelper {
  // Prevent instantiation
  UrlLauncherHelper._();

  /// Launch a web URL in external browser
  static Future<void> launchWebUrl(
    String url, {
    BuildContext? context,
  }) async {
    try {
      final uri = Uri.parse(url);

      // Try to launch without checking canLaunchUrl first
      // This is more reliable on some Android versions
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context != null && context.mounted) {
        _showErrorSnackbar(context, 'Could not open link: $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $url - Error: $e');
      if (context != null && context.mounted) {
        _showErrorSnackbar(context, 'Could not open link');
      }
    }
  }

  /// Launch email client with pre-filled email
  static Future<void> launchEmail({
    required String email,
    String? subject,
    String? body,
    BuildContext? context,
  }) async {
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body,
        },
      );

      final launched = await launchUrl(uri);

      if (!launched && context != null && context.mounted) {
        _showErrorSnackbar(context, 'No email app available');
      }
    } catch (e) {
      debugPrint('Error launching email: $email - Error: $e');
      if (context != null && context.mounted) {
        _showErrorSnackbar(context, 'Could not open email app');
      }
    }
  }

  /// Launch phone dialer with phone number
  static Future<void> launchPhone(
    String phoneNumber, {
    BuildContext? context,
  }) async {
    try {
      final uri = Uri(scheme: 'tel', path: phoneNumber);

      final launched = await launchUrl(uri);

      if (!launched && context != null && context.mounted) {
        _showErrorSnackbar(context, 'Could not open phone dialer');
      }
    } catch (e) {
      debugPrint('Error launching phone: $phoneNumber - Error: $e');
      if (context != null && context.mounted) {
        _showErrorSnackbar(context, 'Could not open phone dialer');
      }
    }
  }

  /// Launch WhatsApp chat
  static Future<void> launchWhatsApp(
    String url, {
    BuildContext? context,
  }) async {
    try {
      final uri = Uri.parse(url);

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context != null && context.mounted) {
        _showErrorSnackbar(context, 'WhatsApp not installed');
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $url - Error: $e');
      if (context != null && context.mounted) {
        _showErrorSnackbar(context, 'Could not open WhatsApp');
      }
    }
  }

  /// Launch app store based on platform
  static Future<void> launchAppStore({
    required String playStoreUrl,
    required String appStoreUrl,
    BuildContext? context,
  }) async {
    // For now, launch Play Store (Android-first approach)
    // TODO: Add platform detection when iOS support is added
    await launchWebUrl(playStoreUrl, context: context);
  }

  /// Show error snackbar
  static void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
