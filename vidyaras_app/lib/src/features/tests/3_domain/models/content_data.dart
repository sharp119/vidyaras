import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_data.freezed.dart';
part 'content_data.g.dart';

/// Represents flexible content that can be text, LaTeX, image, etc.
/// Used for questions, options, and explanations
@freezed
class ContentData with _$ContentData {
  const factory ContentData({
    required String type, // 'text', 'latex', 'image_url', 'video_url', etc.
    required String content, // The actual content (text, LaTeX string, URL, etc.)
  }) = _ContentData;

  factory ContentData.fromJson(Map<String, dynamic> json) =>
      _$ContentDataFromJson(json);

  // Factory constructors for common content types
  factory ContentData.text(String text) => ContentData(
        type: 'text',
        content: text,
      );

  factory ContentData.latex(String latexString) => ContentData(
        type: 'latex',
        content: latexString,
      );

  factory ContentData.imageUrl(String url) => ContentData(
        type: 'image_url',
        content: url,
      );

  factory ContentData.videoUrl(String url) => ContentData(
        type: 'video_url',
        content: url,
      );
}
