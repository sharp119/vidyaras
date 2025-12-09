import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// User profile domain model
/// Extended user information for home/profile screens
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    String? email,
    String? avatarUrl,
    String? bio,
    @Default(false) bool isPremium,
    @Default(0) int enrolledCount,
    @Default(0) int completedCount,
    @Default(0) int certificatesCount,
    @Default(0) int referralPoints,
    List<String>? interests,
    DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
