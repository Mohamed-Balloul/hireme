// class CreateProjectRequestModel {
//   final String name;
//   final String details;
//   final List<String> tools;
//   final String coverImage;

//   CreateProjectRequestModel({
//     required this.name,
//     required this.details,
//     required this.tools,
//     // وضع قيمة افتراضية لحقل صورة الغلاف لتجنب مشاكل الباك-إند حالياً
//     this.coverImage = "projects/analytics.png",
//   });

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {
//       "name": name,
//       "details": details,
//       "cover_image": coverImage,
//     };

//     // تحويل مصفوفة الأدوات تلقائياً إلى حقول فردية: tool1, tool2... إلخ
//     for (int i = 0; i < tools.length; i++) {
//       data["tool${i + 1}"] = tools[i];
//     }

//     return data;
//   }
// }

// استبدل كود كلاس CreateProjectRequestModel بالكامل في ملف الموديل بهذا الكود:

class CreateProjectRequestModel {
  final String name;
  final String details;
  final String
      additionalDetails; // الحقل الجديد المضاف رسمياً لمطابقة تحديث الباك
  final List<String> tools;
  final String coverImage;

  CreateProjectRequestModel({
    required this.name,
    required this.details,
    required this.additionalDetails, // مطلوب بداخل المنشئ
    required this.tools,
    // وضع قيمة افتراضية لحقل صورة الغلاف لتجنب مشاكل الباك-إند حالياً
    this.coverImage = "projects/analytics.png",
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "details": details,
      "additional_details":
          additionalDetails, // إرسال التفاصيل الإضافية بشكل منفصل
      "cover_image": coverImage,
    };

    // تحويل مصفوفة الأدوات تلقائياً إلى حقول فردية: tool1, tool2... إلخ
    for (int i = 0; i < tools.length; i++) {
      data["tool${i + 1}"] = tools[i];
    }

    return data;
  }
}
