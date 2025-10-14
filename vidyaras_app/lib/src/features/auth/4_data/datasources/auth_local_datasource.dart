import '../../3_domain/models/user.dart';

/// Local datasource for authentication
/// Simulates authentication with dummy data for development
class AuthLocalDataSource {
  // Dummy OTP for all phone numbers (development only)
  static const String _dummyOTP = '123456';

  // In-memory storage for registered users
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

  /// Send OTP to phone number (simulated)
  /// Always returns true for valid phone numbers
  Future<bool> sendOTP(String phoneNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In real implementation, this would call an API to send SMS
    // For now, we just validate the phone number format
    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      throw Exception('Invalid phone number');
    }

    // Log the dummy OTP for development
    print('📱 OTP sent to $phoneNumber: $_dummyOTP');
    return true;
  }

  /// Verify OTP and check if user exists
  /// Returns user if exists, null if new user
  Future<User?> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Verify OTP
    if (otp != _dummyOTP) {
      throw Exception('Invalid OTP');
    }

    // Check if user exists
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
