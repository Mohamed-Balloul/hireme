// class StudentNotificationModel {
//   final int? id;
//   final String? senderName;
//   final String? senderImage;
//   final bool? isVerified;
//   final String? type;
//   final String? content;
//   final String? time;
//   bool? isRead;
//   //--
//   final String? status;
//   final String? readAt;
//   final String? sentAt;
//   final String? title;
//   //--

//   StudentNotificationModel({
//     this.id,
//     this.senderName,
//     this.senderImage,
//     this.isVerified,
//     this.content,
//     this.time,
//     this.isRead,
//     this.type,
//     //--
//     this.status,
//     this.readAt,
//     this.sentAt,
//     this.title,
//   });
//   //--
//   factory StudentNotificationModel.fromJson(Map<String, dynamic> json) {
//     return StudentNotificationModel(
//       id: json['id'],
//       status: json['status'],
//       readAt: json['read_at'],
//       sentAt: json['sent_at'],
//       // البيانات الأساسية موجودة داخل كائن متداخل اسمه notification
//       title: json['notification']['title'],
//       content: json['notification']['body'],
//       type: json['notification']['type'],
//       //
//       senderName: json['senderName'] ?? "sender name",
//       senderImage: json['senderImage'] ?? "",
//       isVerified: json['isVerified'] ?? false,
//       time: json['time'] ?? "",
//       isRead: json['isRead'] ?? false,
//     );
//   }
// }
//------------------------
class StudentNotificationModel {
  final int? id;
  final String? senderName;
  final String? senderImage;
  final bool? isVerified;
  final String? type;
  final String? content;
  final String? time;
  bool? isRead;

  // حقول إضافية للمطابقة الكاملة مع السيرفر
  final String? status;
  final String? readAt;
  final String? sentAt;
  final String? title;

  StudentNotificationModel({
    this.id,
    this.senderName,
    this.senderImage,
    this.isVerified,
    this.content,
    this.time,
    this.isRead,
    this.type,
    this.status,
    this.readAt,
    this.sentAt,
    this.title,
  });

  factory StudentNotificationModel.fromJson(Map<String, dynamic> json) {
    // استخراج الكائن المتداخل 'notification' بأمان
    final notificationData = json['notification'] as Map<String, dynamic>?;
    //--
    // 1. استخراج النوع الخام من السيرفر
    final String rawType = notificationData?['type'] ?? "system";

    // 2. تحويل النوع الإنجليزي إلى العربي المستخدم في الفلاتر والواجهة
    String mappedType = "أدمن";
    if (rawType == "company" || rawType == "company_announcement") {
      mappedType = "شركات";
    } else if (rawType == "customer" ||
        rawType == "client" ||
        rawType == "project") {
      mappedType = "عملاء";
    } else {
      mappedType = "أدمن"; // افتراضي للإشعارات الإدارية والنظام
    }

    //--

    // 1. حساب حالة القراءة (isRead) بناءً على قيمة read_at المرسلة من السيرفر
    // إذا كانت القيمة غير فارغة، فهذا يعني أنه تم قراءة الإشعار
    final bool computedIsRead = json['read_at'] != null;

    // 2. تنسيق الوقت بشكل آمن ومقروء
    String formattedTime = "منذ قليل";
    if (json['sent_at'] != null) {
      formattedTime =
          _parseDateTimeToFriendlyString(json['sent_at'].toString());
    } else if (notificationData?['created_at'] != null) {
      formattedTime = _parseDateTimeToFriendlyString(
          notificationData!['created_at'].toString());
    }

    return StudentNotificationModel(
      // مُعرّف استلام الإشعار (مهم لعملية الحذف الفردي)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      status: json['status'] ?? "sent",
      readAt: json['read_at'],
      sentAt: json['sent_at'],

      // جلب البيانات الأساسية من داخل كائن 'notification' المتداخل
      title: notificationData?['title'] ?? "إشعار جديد",
      content: notificationData?['body'] ?? "لا يوجد محتوى متوفر للإشعار.",
      // type: notificationData?['type'] ?? "system",
      type: mappedType,

      // ربط وتوفير قيم افتراضية دفاعية للمتغيرات المستخدمة في واجهة BuildNotificationsItem
      senderName: notificationData?['title'] ??
          "إدارة المنصة", // استخدام عنوان الإشعار كاسم للمرسل عند عدم توفر حقل مستقل
      senderImage:
          "https://cdn-icons-png.flaticon.com/512/3602/3602145.png", // أيقونة جرس إشعارات افتراضية جذابة للنظام لمنع كراش الصورة
      isVerified: notificationData?['type'] ==
          "admin_announcement", // توثيق تلقائي لمرسل الإشعار إذا كان إعلاناً رسمياً
      time: formattedTime,
      isRead: computedIsRead,
    );
  }

  // دالة مساعدة ومحمية لتحويل التاريخ بصيغة ISO إلى تنسيق تاريخ بسيط ومقروء
  static String _parseDateTimeToFriendlyString(String isoString) {
    try {
      DateTime parsedDate = DateTime.parse(isoString);
      return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "منذ قليل";
    }
  }
}
