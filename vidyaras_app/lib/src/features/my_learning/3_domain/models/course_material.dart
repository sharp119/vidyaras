import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_material.freezed.dart';
part 'course_material.g.dart';

/// Represents downloadable course materials (PDFs, docs, etc.)
@freezed
class CourseMaterial with _$CourseMaterial {
  const factory CourseMaterial({
    required String id,
    required String courseId,
    required String title,
    @Default('pdf') String type, // pdf, video, doc, image, other
    required String fileUrl,
    double? fileSizeMb,
    String? sectionId, // matches SQL schema's section_id field
    DateTime? createdAt,
  }) = _CourseMaterial;

  factory CourseMaterial.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialFromJson(json);
}

extension CourseMaterialX on CourseMaterial {
  /// Get file extension from type
  String get fileExtension {
    switch (type) {
      case 'pdf':
        return 'PDF';
      case 'doc':
        return 'DOC';
      case 'video':
        return 'MP4';
      case 'image':
        return 'JPG';
      default:
        return type.toUpperCase();
    }
  }

  /// Format file size for display
  String get formattedSize {
    if (fileSizeMb == null) return '';
    if (fileSizeMb! < 1) {
      return '${(fileSizeMb! * 1024).toStringAsFixed(0)} KB';
    }
    return '${fileSizeMb!.toStringAsFixed(1)} MB';
  }
}
