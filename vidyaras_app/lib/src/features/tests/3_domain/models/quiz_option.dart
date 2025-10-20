import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_data.dart';

part 'quiz_option.freezed.dart';
part 'quiz_option.g.dart';

/// Represents a single option in a multiple-choice question
@freezed
class QuizOption with _$QuizOption {
  const factory QuizOption({
    required int id, // 0-based index
    required ContentData data, // The option content (can be text, LaTeX, image, etc.)
  }) = _QuizOption;

  factory QuizOption.fromJson(Map<String, dynamic> json) =>
      _$QuizOptionFromJson(json);
}
