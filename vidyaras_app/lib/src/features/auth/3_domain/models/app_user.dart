import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// AppUser domain model
/// Maps to the profiles table in Supabase
/// Represents a user authenticated via Google OAuth with phone verification
@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    /// User ID (matches auth.users.id)
    required String id,

    /// Email from Google OAuth
    required String? email,

    /// Full name from Google OAuth metadata
    required String? fullName,

    /// Display name (same as fullName)
    required String? name,

    /// Avatar URL from Google OAuth
    required String? avatarUrl,

    /// Phone number (E.164 format, e.g., +911234567890)
    /// Verified via MSG91 OTP
    String? phoneNumber,

    /// Whether user has completed onboarding
    @Default(false) bool isOnboarded,

    /// Onboarding preferences (interests, goals, experience, language)
    @Default({}) Map<String, dynamic> preferences,

    /// User role (student, teacher, admin)
    @Default('student') String role,

    /// Created timestamp
    DateTime? createdAt,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
