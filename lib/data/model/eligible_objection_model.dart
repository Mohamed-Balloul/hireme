// //-------------------------
// // ملف الموديل: lib/data/model/eligilbe_objection_model.dart

// class EligibleObjectionModel {
//   final int? id; // يمثل الـ project_application_id المطلوب للاعتراض
//   final String? projectTitle;
//   final String? studentName;
//   final String? timeAgo;

//   EligibleObjectionModel({
//     this.id,
//     this.projectTitle,
//     this.studentName,
//     this.timeAgo,
//   });

//   factory EligibleObjectionModel.fromJson(Map<String, dynamic> rawJson) {
//     final Map<String, dynamic> json =
//         (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

//     // استخراج الكائنات المتداخلة لطلب الاعتراض
//     final project = json['project'] as Map<String, dynamic>?;
//     final student = json['student'] as Map<String, dynamic>?;

//     // حساب الفارق الزمني الحقيقي وتنسيقه بالعربية
//     String formattedTime = "منذ شهر";
//     if (json['created_at'] != null) {
//       formattedTime =
//           _parseDateTimeToFriendlyString(json['created_at'].toString());
//     }

//     return EligibleObjectionModel(
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
//       projectTitle:
//           project?['name'] ?? "عنوان المشروع غير محدد", // تم تصحيح الكتابة هنا
//       studentName: student?['username'] ?? student?['name'] ?? "المنفذ",
//       timeAgo: formattedTime,
//     );
//   }

//   // دالة مساعدة لحساب الفارق الزمني وعرض الوقت بشكل منسق ومقروء بالعربية تلقائياً
//   static String _parseDateTimeToFriendlyString(String isoString) {
//     try {
//       DateTime parsedDate = DateTime.parse(isoString);
//       Duration diff = DateTime.now().difference(parsedDate);
//       if (diff.inDays > 0) {
//         return "منذ ${diff.inDays} يوم";
//       } else if (diff.inHours > 0) {
//         return "منذ ${diff.inHours} ساعة";
//       } else if (diff.inMinutes > 0) {
//         return "منذ ${diff.inMinutes} دقيقة";
//       } else {
//         return "منذ قليل";
//       }
//     } catch (e) {
//       return "منذ شهر";
//     }
//   }
// }

//-------------
// ملف الموديل: lib/data/model/eligible_objection_model.dart

class EligibleObjectionModel {
  final int? id; // يمثل الـ project_application_id المطلوب للاعتراض
  final String? projectTitle;
  final String? studentName;
  final String? timeAgo;

  EligibleObjectionModel({
    this.id,
    this.projectTitle,
    this.studentName,
    this.timeAgo,
  });

  factory EligibleObjectionModel.fromJson(Map<String, dynamic> rawJson) {
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    // استخراج الكائنات المتداخلة لطلب الاعتراض
    final project = json['project'] as Map<String, dynamic>?;
    final student = json['student'] as Map<String, dynamic>?;

    // حساب الفارق الزمني الحقيقي وتنسيقه بالعربية بناءً على تاريخ تسليم الطلب
    String formattedTime = "منذ شهر";
    if (json['created_at'] != null) {
      formattedTime =
          _parseDateTimeToFriendlyString(json['created_at'].toString());
    }

    return EligibleObjectionModel(
      // معرف تقديم المشروع الأساسي (ID الطلب)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // استخراج عنوان المشروع المتداخل
      projectTitle:
          project?['name'] ?? "عنوان المشروع غير حدد", // تم تصحيح الكتابة هنا

      // جلب اسم الطالب المنفذ الفعلي بأمان (البحث في حقل name أولاً المضاف حديثاً، ثم username كاحتياط)
      studentName: student?['name'] ?? student?['username'] ?? "المنفذ",

      // إسناد الوقت المنسق
      timeAgo: formattedTime,
    );
  }

  // دالة مساعدة لحساب الفارق الزمني وعرض الوقت بشكل منسق ومقروء بالعربية تلقائياً
  static String _parseDateTimeToFriendlyString(String isoString) {
    try {
      DateTime parsedDate = DateTime.parse(isoString);
      Duration diff = DateTime.now().difference(parsedDate);
      if (diff.inDays > 0) {
        return "منذ ${diff.inDays} يوم";
      } else if (diff.inHours > 0) {
        return "منذ ${diff.inHours} ساعة";
      } else if (diff.inMinutes > 0) {
        return "منذ ${diff.inMinutes} دقيقة";
      } else {
        return "منذ قليل";
      }
    } catch (e) {
      return "منذ شهر";
    }
  }
}
