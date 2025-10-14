import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User domain model
/// Represents a user in the VidyaRas application
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String phoneNumber,
    required String name,
    String? email,
    String? avatarUrl,
    @Default(false) bool isNewUser,
    DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
