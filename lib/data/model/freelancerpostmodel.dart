// class FreelancerPostModel {
//   final int? id;
//   final String? publisher;
//   final int? publisherId;
//   final String? logo;
//   final String? content;

//   final String? time;
//   final int? applicants;
//   final String? serviceTitle;
//   final List<String>? tools;
//   final String? date;
//   final String? description;
//   final String? files;
//   final String? image;
//   final String? additionalDetails;

//   FreelancerPostModel({
//     this.id,
//     this.publisher,
//     this.publisherId,
//     this.serviceTitle,
//     this.content,
//     this.tools,
//     this.date,
//     this.description,
//     this.files,
//     this.logo,
//     this.time,
//     this.applicants,
//     this.image,
//     this.additionalDetails,
//   });

//   factory FreelancerPostModel.fromJson(Map<String, dynamic> json) {
//     return FreelancerPostModel(
//       id: json['id'] ?? 1,
//       publisher: json['customer']['name'] ?? "customer name",
//       publisherId: json['customer']['id'] ?? 1,
//       serviceTitle: json['name'] ?? "serviceTitle",
//       content: json['content'] ??
//           "أبحث عن مطور فلاتر محترف لبناء متجر لبيع الملابس الرجالية. التطبيق يجب أن يدعم الدفع الإلكتروني وتتبع الطلبات.",
//       logo: json['customer']['logo'] ??
//           "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
//       time: json['since'] ?? "منذ يومين",
//       image: json['image'] ??
//           'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop',
//       applicants: json['applicants_count'] ?? 12,
//       description: json['description'] ??
//           "أبحث عن مطور فلاتر محترف لبناء متجر لبيع الملابس الرجالية. التطبيق يجب أن يدعم الدفع الإلكتروني وتتبع الطلبات.",
//       tools: json['tools'] != null ? List<String>.from(json['tools']) : [],
//       additionalDetails: json['additionalDetails'] ?? "the additionalDetails",
//       date: json['date'] ?? "",
//       files: json['files'] ?? "",
//     );
//   }
// }
//----------------
class FreelancerPostModel {
  final int? id;
  final String? publisher;
  final int? publisherId;
  final String? logo;
  final String? content;

  final String? time;
  final int? applicants;
  final String? serviceTitle;
  final List<String>? tools;
  final String? date;
  final String? description;
  final String? files;
  final String? image;
  final String? additionalDetails;

  FreelancerPostModel({
    this.id,
    this.publisher,
    this.publisherId,
    this.serviceTitle,
    this.content,
    this.tools,
    this.date,
    this.description,
    this.files,
    this.logo,
    this.time,
    this.applicants,
    this.image,
    this.additionalDetails,
  });

  factory FreelancerPostModel.fromJson(Map<String, dynamic> json) {
    // استخراج الكائن الفرعي للعميل (customer) بأمان
    final customer = json['customer'] as Map<String, dynamic>?;

    // معالجة ذكية للأدوات التقنية المطلوبة (tools) في حال عدم إرسالها من الباك
    final rawTools = json['tools'];
    final List<String> toolsList =
        (rawTools != null && rawTools is List && rawTools.isNotEmpty)
            ? List<String>.from(rawTools)
            : [
                "Flutter",
                "Dart",
                "REST API",
                "Git"
              ]; // أدوات افتراضية تناسب المشاريع التقنية

    return FreelancerPostModel(
      // 1. استخدام int.tryParse لتحويل آمن للمعرف (id)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // 2. ربط حقل اسم العميل بـ publisher ومعرفه بـ publisherId
      publisher: customer?['name'] ?? "عميل غير معرف",
      publisherId: customer?['id'] != null
          ? int.tryParse(customer!['id'].toString())
          : null,

      // 3. ربط حقل "name" الوارد في أعلى كائن المشروع بالمتغير "serviceTitle" المستخدم في السلايدر
      serviceTitle: json['name'] ?? "عنوان المشروع غير محدد",

      // 4. تعيين تفاصيل محتوى افتراضية في حال عدم إرسال "content"
      content: json['content'] ??
          "نبحث عن مستقل متمكن للعمل على إنجاز وتطوير هذا المشروع وفقاً لأفضل المعايير الفنية والتقنية المطلوبة.",

      // 5. محاولة إحضار صورة العميل أو توفير رابط افتراضي
      logo: customer?['logo'] ??
          customer?['image'] ??
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",

      // 6. ربط حقل "since" بالمتغير "time"
      time: json['since'] ?? "منذ ساعات",

      // 7. صورة غلاف المشروع مع إعداد قيمة افتراضية مناسبة
      image: json['image'] ??
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop',

      // 8. ربط حقل "applicants_count" بالمتغير "applicants" بشكل آمن عددياً
      applicants: json['applicants_count'] != null
          ? int.tryParse(json['applicants_count'].toString())
          : 0,

      description: json['description'] ??
          "نبحث عن مستقل متمكن للعمل على إنجاز وتطوير هذا المشروع وفقاً لأفضل المعايير الفنية والتقنية المطلوبة.",

      tools: toolsList,
      additionalDetails: json['additionalDetails'] ??
          "لا تتوفر تفاصيل إضافية لهذا المشروع حالياً.",
      date: json['date'] ?? "مستمر",
      files: json['files'] ?? "",
    );
  }
}
