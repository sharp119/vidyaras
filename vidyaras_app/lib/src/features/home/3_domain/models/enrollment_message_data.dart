import 'package:freezed_annotation/freezed_annotation.dart';

part 'enrollment_message_data.freezed.dart';

/// Data required to generate enrollment contact messages
@freezed
class EnrollmentMessageData with _$EnrollmentMessageData {
  const factory EnrollmentMessageData({
    // User data
    required String userName,
    required String userPhone,
    String? userEmail,

    // Course data
    required String courseTitle,
    required String instructor,
    required String courseType, // 'Live Classes' or 'Recorded Course'

    // Pricing
    required String selectedPrice,
    required bool isFullPayment,

    // Live course specific
    String? batchName,
    String? batchSchedule,
    String? batchStartDate,

    // Recorded course specific
    int? accessDays,

    // Additional
    @Default(false) bool isFree,
  }) = _EnrollmentMessageData;

  const EnrollmentMessageData._();

  /// Generate formatted message for sharing (WhatsApp, Email, SMS, etc.)
  String toShareMessage() {
    final buffer = StringBuffer();
    buffer.writeln('Hello VidyaRas Team! 👋\n');
    buffer.writeln('I would like to enroll in:\n');
    buffer.writeln('📚 Course: $courseTitle');
    buffer.writeln('👨‍🏫 Instructor: $instructor');
    buffer.writeln('📱 Name: $userName');
    buffer.writeln('📞 Phone: $userPhone');

    if (batchName != null) {
      buffer.writeln('\n🎓 Batch Details:');
      buffer.writeln('• Batch: $batchName');
      buffer.writeln('• Schedule: $batchSchedule');
      buffer.writeln('• Starts: $batchStartDate');
    }

    if (accessDays != null) {
      buffer.writeln('\n⏱️ Access Period: $accessDays days');
    }

    if (!isFree) {
      buffer.writeln('\n💰 Payment Option:');
      buffer.writeln(isFullPayment
          ? '• Pay Full: $selectedPrice'
          : '• Monthly EMI: $selectedPrice');
    }

    buffer.writeln('\nPlease share the enrollment details. Thank you!');

    return buffer.toString();
  }
}
