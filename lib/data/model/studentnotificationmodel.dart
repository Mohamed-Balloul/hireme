class StudentNotificationModel {
  final int? id;
  final String? senderName;
  final String? senderImage;
  final bool? isVerified;
  final String? type;
  final String? content;
  final String? time;
  final bool? isRead;

  StudentNotificationModel({
    this.id,
    this.senderName,
    this.senderImage,
    this.isVerified,
    this.content,
    this.time,
    this.isRead,
    this.type,
  });
}
