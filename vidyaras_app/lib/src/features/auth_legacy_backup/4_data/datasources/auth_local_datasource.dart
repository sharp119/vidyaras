import '../../3_domain/models/user.dart';
import '../services/msg91_service.dart';

/// Auth datasource using MSG91 SDK for OTP
/// Handles real OTP sending and verification via MSG91
class AuthLocalDataSource {
  final Msg91Service _msg91Service;

  // In-memory storage for registered users (temporary - will use Supabase later)
  final Map<String, User> _registeredUsers = {
    // Pre-registered test user
    '+911234567890': User(
      id: 'user_1',
      phoneNumber: '+911234567890',
      name: 'Test User',
      email: 'test@example.com',
      isNewUser: false,
      createdAt: DateTime.now(),
    ),
  };

  // Current authenticated user
  User? _currentUser;

  AuthLocalDataSource(this._msg91Service);

  /// Send OTP to phone number via MSG91 SDK
  /// Returns requestId needed for verification
  Future<String> sendOTP(String phoneNumber) async {
    // Validate phone number format
    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      throw Exception('Invalid phone number');
    }

    // Send OTP via MSG91 SDK - returns requestId
    final requestId = await _msg91Service.sendOTP(phoneNumber: phoneNumber);
    print('✅ OTP sent successfully to $phoneNumber, requestId: $requestId');

    return requestId;
  }

  /// Verify OTP via MSG91 SDK and check if user exists
  /// Returns user if exists, null if new user
  Future<User?> verifyOTP({
    required String requestId,
    required String otp,
    required String phoneNumber,
  }) async {
    // Verify OTP via MSG91 SDK - returns access token
    final accessToken = await _msg91Service.verifyOTP(
      requestId: requestId,
      otp: otp,
    );

    print('✅ OTP verified successfully, accessToken received');

    // Check if user exists in our system
    final user = _registeredUsers[phoneNumber];

    if (user != null) {
      // Existing user - set as current user
      _currentUser = user;
      print('✅ Existing user logged in: ${user.name}');
    } else {
      print('🆕 New user detected: $phoneNumber');
    }

    return user;
  }

  /// Register new user
  Future<User> registerUser({
    required String phoneNumber,
    required String name,
    String? email,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Create new user
    final newUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: phoneNumber,
      name: name,
      email: email,
      isNewUser: true,
      createdAt: DateTime.now(),
    );

    // Store user
    _registeredUsers[phoneNumber] = newUser;
    _currentUser = newUser;

    print('✅ New user registered: ${newUser.name}');
    return newUser;
  }

  /// Get current user
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  /// Sign out
  Future<bool> signOut() async {
    _currentUser = null;
    print('👋 User signed out');
    return true;
  }
}
