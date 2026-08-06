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

  factory FreelancerPostModel.fromJson(Map<String, dynamic> rawJson) {
    // خطوة أمان: التحقق مما إذا كان المدخل هو الاستجابة الكاملة أو كائن data الداخلي مباشرة
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    // استخراج الكائن الفرعي للعميل (customer) بأمان
    final customer = json['customer'] as Map<String, dynamic>?;

    // 1. معالجة وتجميع الأدوات التقنية المطلوبة (tools) ديناميكياً من حقول tool1 إلى tool5
    final List<String> toolsList = [];
    for (int i = 1; i <= 5; i++) {
      final tool = json['tool$i'];
      if (tool != null && tool.toString().trim().isNotEmpty) {
        toolsList.add(tool.toString());
      }
    }
    if (toolsList.isEmpty) {
      toolsList.addAll([
        "Flutter",
        "Dart",
        "REST API",
        "Git"
      ]); // أدوات افتراضية عند عدم الإرسال
    }

    return FreelancerPostModel(
      // استخدام المعرف (id) بشكل محمي رقمياً
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // ربط حقل اسم العميل بـ publisher ومعرفه بـ publisherId
      publisher: customer?['name'] ?? "عميل غير معرف",
      publisherId: json['customer_id'] != null
          ? int.tryParse(json['customer_id'].toString())
          : (customer?['id'] != null
              ? int.tryParse(customer!['id'].toString())
              : null),

      // ربط حقل "name" بالمتغير "serviceTitle" المستخدم في السلايدر والواجهة لديك
      serviceTitle: json['name'] ?? "عنوان المشروع غير محدد",

      // تفاصيل محتوى افتراضية في حال عدم إرسال "content" أو "details"
      content: json['content'] ??
          json['details'] ??
          "نبحث عن مستقل متمكن للعمل على إنجاز وتطوير هذا المشروع وفقاً لأفضل المعايير الفنية والتقنية المطلوبة.",

      logo:
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop", // إسناد الرابط الكامل للوجو العميل
      image:
          "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop", // إسناد الرابط الكامل لغلاف المشروع

      // logo: fullLogo, // إسناد الرابط الكامل للوجو العميل
      // image: fullCover, // إسناد الرابط الكامل لغلاف المشروع

      // ربط حقل "since" بالمتغير "time"
      // time: json['since'] ?? "منذ ساعات",
      // ربط حقل "since" بالمتغير "time" مع التنسيق الجمالي لإزالة الكسور العشرية
      time: _formatFriendlyTime(json['since']?.toString()),
      // ربط حقل "applicants_count" بالمتغير "applicants" بشكل آمن عددياً
      applicants: json['applicants_count'] != null
          ? int.tryParse(json['applicants_count'].toString())
          : 0,

      description: json['details'] ??
          json['description'] ??
          "نبحث عن مستقل متمكن للعمل على إنجاز وتطوير هذا المشروع وفقاً لأفضل المعايير الفنية والتقنية المطلوبة.",

      tools: toolsList,

      additionalDetails: json['additional_details'] ??
          json['additionalDetails'] ??
          "لا تتوفر تفاصيل إضافية لهذا المشروع حالياً.",

      date: json['date'] ?? "مستمر",
      files: json['files'] ?? "",
    );
  }
  // دالة مساعدة ذكية لتنسيق الوقت وإزالة الأرقام العشرية الطويلة القادمة من السيرفر
  static String _formatFriendlyTime(String? rawSince) {
    if (rawSince == null || rawSince.trim().isEmpty) {
      return "منذ ساعات";
    }
    try {
      // تقسيم السلسلة النصية بالفراغات
      // مثال: "1.25430361 day ago" -> ["1.25430361", "day", "ago"]
      List<String> parts = rawSince.trim().split(' ');
      if (parts.isNotEmpty) {
        double? parsedNumber = double.tryParse(parts[0]);
        if (parsedNumber != null) {
          // تقريب الرقم لأقرب عدد صحيح (مثلاً 1.25 تصبح 1 و 1.98 تصبح 2)
          int roundedNumber = parsedNumber.round();

          String unit = parts.length > 1 ? parts[1] : "day";
          String suffix = parts.length > 2 ? parts[2] : "ago";

          // تصحيح قواعد الجمع البسيطة للغة الإنجليزية
          if (roundedNumber > 1) {
            if (unit == "day") unit = "days";
            if (unit == "hour") unit = "hours";
            if (unit == "minute") unit = "minutes";
          } else {
            if (unit == "days") unit = "day";
            if (unit == "hours") unit = "hour";
            if (unit == "minutes") unit = "minute";
          }

          return "$roundedNumber $unit $suffix";
        }
      }
    } catch (e) {
      print("Error parsing since time: $e");
    }
    return rawSince; // في حال الفشل نرجع النص الأصلي كحماية
  }
}
