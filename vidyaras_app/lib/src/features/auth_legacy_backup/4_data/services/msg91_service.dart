import 'dart:convert';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';
import 'package:http/http.dart' as http;

/// MSG91 OTP Service
/// Handles sending and verifying OTPs via MSG91 Flutter SDK
class Msg91Service {
  // MSG91 Credentials
  static const String _widgetId = '356a716c6a55373639373338';
  static const String _authToken = '444220TeBqDnUxw68f23323P1';
  static const String _authKey = '444220AXFE5eEZ68f233a6P1';
  static const String _verifyTokenUrl = 'https://control.msg91.com/api/v5/widget/verifyAccessToken';

  bool _isInitialized = false;

  /// Initialize the MSG91 SDK (call once at app startup)
  Future<void> initialize() async {
    if (!_isInitialized) {
      try {
        print('📱 MSG91Service: Initializing SDK');
        OTPWidget.initializeWidget(_widgetId, _authToken);
        _isInitialized = true;
        print('✅ MSG91Service: Initialized successfully');
      } catch (e) {
        print('❌ MSG91Service: Error during initialization: $e');
        throw Exception('Failed to initialize MSG91 service: $e');
      }
    }
  }

  /// Send OTP to phone number via MSG91 SDK
  /// Returns requestId needed for verification
  Future<String> sendOTP({required String phoneNumber}) async {
    try {
      print('📱 MSG91Service: Sending OTP to ${_maskPhone(phoneNumber)}');

      if (!_isInitialized) {
        await initialize();
      }

      // MSG91 SDK expects format: 91XXXXXXXXXX (without +)
      final cleanPhone = phoneNumber.replaceAll(RegExp(r'[+\s-]'), '');

      final data = {'identifier': cleanPhone};
      final response = await OTPWidget.sendOTP(data);

      if (response == null || response['message'] == null) {
        throw Exception('Invalid response from MSG91 SDK');
      }

      final requestId = response['message'];
      print('✅ MSG91Service: OTP sent successfully, requestId: $requestId');

      return requestId;
    } catch (e) {
      print('❌ MSG91Service: Error sending OTP: $e');
      throw Exception('Failed to send OTP: $e');
    }
  }

  /// Verify OTP via MSG91 SDK
  /// Returns access token on success
  Future<String> verifyOTP({
    required String requestId,
    required String otp,
  }) async {
    try {
      print('🔐 MSG91Service: Verifying OTP for requestId: $requestId');

      if (!_isInitialized) {
        await initialize();
      }

      final data = {
        'reqId': requestId,
        'otp': otp,
      };

      final response = await OTPWidget.verifyOTP(data);

      if (response == null || response['message'] == null) {
        throw Exception('Invalid response from MSG91 verification');
      }

      final accessToken = response['message'];
      print('✅ MSG91Service: OTP verified successfully');

      // Verify the access token with MSG91 server
      final isValid = await _verifyAccessToken(accessToken);

      if (!isValid) {
        throw Exception('Access token verification failed');
      }

      return accessToken;
    } catch (e) {
      print('❌ MSG91Service: Error verifying OTP: $e');
      throw Exception('Failed to verify OTP: $e');
    }
  }

  /// Verify the access token with MSG91 server
  Future<bool> _verifyAccessToken(String accessToken) async {
    try {
      print('🔐 MSG91Service: Verifying access token');

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        'authkey': _authKey,
        'access-token': accessToken,
      });

      final response = await http.post(
        Uri.parse(_verifyTokenUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Case 1: Success response
        if (responseData['type'] == 'success') {
          print('✅ MSG91Service: Access token verified successfully');
          return true;
        }

        // Case 2: "Already verified" error (code 702) - This is actually valid
        if (responseData['code'] == 702 ||
            (responseData['message'] != null &&
                responseData['message'].toString().contains('already verified'))) {
          print('✅ MSG91Service: Token already verified (valid)');
          return true;
        }
      }

      print('❌ MSG91Service: Access token verification failed: ${response.body}');
      return false;
    } catch (e) {
      print('❌ MSG91Service: Error verifying access token: $e');
      return false;
    }
  }

  /// Mask phone number for logging (security)
  String _maskPhone(String phone) {
    if (phone.length <= 4) return phone;
    return 'XXXXXX${phone.substring(phone.length - 4)}';
  }
}
