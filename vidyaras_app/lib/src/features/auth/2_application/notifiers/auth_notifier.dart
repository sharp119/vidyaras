import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../../4_data/datasources/auth_local_datasource.dart';
import '../../4_data/repositories/auth_repository_impl.dart';
import '../state/auth_state.dart';

part 'auth_notifier.g.dart';

/// Auth notifier
/// Manages authentication state and business logic
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthRepository _authRepository;

  @override
  AuthState build() {
    // Initialize repository
    _authRepository = AuthRepositoryImpl(AuthLocalDataSource());
    return const AuthState.initial();
  }

  /// Send OTP to phone number
  Future<void> sendOTP(String phoneNumber) async {
    state = const AuthState.sendingOTP();

    final result = await _authRepository.sendOTP(phoneNumber);

    result.fold(
      (failure) {
        state = AuthState.error(message: failure.message);
      },
      (success) {
        state = AuthState.otpSent(phoneNumber: phoneNumber);
      },
    );
  }

  /// Verify OTP
  Future<void> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    state = const AuthState.verifyingOTP();

    final result = await _authRepository.verifyOTP(
      phoneNumber: phoneNumber,
      otp: otp,
    );

    result.fold(
      (failure) {
        state = AuthState.error(message: failure.message);
      },
      (authResult) {
        state = AuthState.otpVerified(authResult: authResult);
      },
    );
  }

  /// Register new user
  Future<void> registerUser({
    required String phoneNumber,
    required String name,
    String? email,
  }) async {
    state = const AuthState.registering();

    final result = await _authRepository.registerUser(
      phoneNumber: phoneNumber,
      name: name,
      email: email,
    );

    result.fold(
      (failure) {
        state = AuthState.error(message: failure.message);
      },
      (user) {
        state = AuthState.authenticated(user: user);
      },
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const AuthState.initial();
  }

  /// Reset to initial state
  void reset() {
    state = const AuthState.initial();
  }
}
