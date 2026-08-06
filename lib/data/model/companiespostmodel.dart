// class CompaniesPostModel {
//   final int? id;
//   final String? companyName;
//   final int? companyId;
//   final String? jobTitle; //
//   final String? logo;
//   final String? time;
//   final String? image;
//   final int? applicants;
//   final String? content; //
//   final List<String>? mainResponsibilities; //
//   final List<String>? requirements; //
//   final List<String>? benefits; //
//   final String? additionalDetails; //
//   final bool? isCvRequired; //
//   final bool? isGitHubOrPortfolioRequired; //
//   final bool? isSalaryRequired; //

//   CompaniesPostModel({
//     this.id,
//     this.companyName,
//     this.companyId,
//     this.jobTitle,
//     this.logo,
//     this.time,
//     this.image,
//     this.applicants,
//     this.content,
//     this.mainResponsibilities,
//     this.requirements,
//     this.benefits,
//     this.additionalDetails,
//     this.isCvRequired,
//     this.isGitHubOrPortfolioRequired,
//     this.isSalaryRequired,
//   });
//   // تحويل البيانات من JSON إلى نموذج CompaniesPostModel
//   factory CompaniesPostModel.fromJson(Map<String, dynamic> json) {
//     return CompaniesPostModel(
//       id: json['id'] ?? 1,
//       companyName: json['company']['name'] ?? "company name",
//       companyId: json['company']['id'] ?? 1,
//       jobTitle: json['job_name'] ?? "job title",
//       logo: json['company']['image'] ??
//           "https://cdn-icons-png.flaticon.com/512/732/732221.png",
//       time: json['since'] ?? "منذ يومين",
//       image: json['image'] ??
//           "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
//       applicants: json['applicants_count'] ?? 12,
//       content: json['content'] ??
//           "نبحث عن مطور فلاتر خبير للانضمام لفريقنا. يجب أن يكون لديه خبرة في التعامل مع الخرائط و REST APIs...",
//       mainResponsibilities: json['mainResponsibilities'] != null
//           ? List<String>.from(json['mainResponsibilities'])
//           : [],
//       requirements: json['requirements'] != null
//           ? List<String>.from(json['requirements'])
//           : [],
//       benefits:
//           json['benefits'] != null ? List<String>.from(json['benefits']) : [],
//       additionalDetails: json['additionalDetails'] ?? "the additionalDetails",
//       isCvRequired: json['isCvRequired'] ?? true,
//       isGitHubOrPortfolioRequired: json['isGitHubOrPortfolioRequired'] ?? true,
//       isSalaryRequired: json['isSalaryRequired'] ?? true,
//     );
//   }
// }
//---------------
// class CompaniesPostModel {
//   final int? id;
//   final String? companyName;
//   final int? companyId;
//   final String? jobTitle;
//   final String? logo;
//   final String? time;
//   final String? image;
//   final int? applicants;
//   final String? content;
//   final List<String>? mainResponsibilities;
//   final List<String>? requirements;
//   final List<String>? benefits;
//   final String? additionalDetails;
//   final bool? isCvRequired;
//   final bool? isGitHubOrPortfolioRequired;
//   final bool? isSalaryRequired;

//   CompaniesPostModel({
//     this.id,
//     this.companyName,
//     this.companyId,
//     this.jobTitle,
//     this.logo,
//     this.time,
//     this.image,
//     this.applicants,
//     this.content,
//     this.mainResponsibilities,
//     this.requirements,
//     this.benefits,
//     this.additionalDetails,
//     this.isCvRequired,
//     this.isGitHubOrPortfolioRequired,
//     this.isSalaryRequired,
//   });

//   // تحويل البيانات من JSON إلى نموذج CompaniesPostModel بطريقة آمنة ودفاعية
//   factory CompaniesPostModel.fromJson(Map<String, dynamic> json) {
//     // استخراج الكائن الفرعي للشركة بأمان للتعامل مع السيناريوهات التي قد يكون فيها فارغاً (null)
//     final company = json['company'] as Map<String, dynamic>?;

//     return CompaniesPostModel(
//       // 1. استخدام int.tryParse لضمان عدم حدوث كراش لو تم إرسال المعرف كنص من السيرفر
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

//       // 2. معالجة بيانات الشركة مع قيم بديلة واضحة
//       companyName: company?['name'] ?? "اسم الشركة غير محدد",
//       companyId: company?['id'] != null
//           ? int.tryParse(company!['id'].toString())
//           : null,

//       // 3. ربط حقل job_name الوارد من الباك بالمتغير القديم jobTitle
//       jobTitle: json['job_name'] ?? "عنوان الوظيفة غير محدد",

//       // 4. تعيين اللوجو مع البحث في روابط مختلفة (image أو logo) وإدراج رابط افتراضي عند عدم التوفر
//       logo: company?['image'] ??
//           company?['logo'] ??
//           "https://cdn-icons-png.flaticon.com/512/732/732221.png",

//       // 5. ربط حقل since بالمتغير القديم time
//       time: json['since'] ?? "منذ مدة",

//       // 6. صورة الغلاف للإعلان مع رابط افتراضي عند عدم توفرها في الرد الحالي
//       image: json['image'] ??
//           "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",

//       // 7. ربط حقل applicants_count بالمتغير القديم applicants مع التحويل الآمن للأرقام
//       applicants: json['applicants_count'] != null
//           ? int.tryParse(json['applicants_count'].toString())
//           : 0,

//       // 8. حقول تفصيلية غير متوفرة في الرد الحالي، تم تعيين قيم افتراضية آمنة لها لمنع حدوث أخطاء بالواجهات
//       content: json['content'] ??
//           "نبحث عن محترفين ومطورين شغوفين للانضمام إلى فريق العمل والمساهمة في مشاريعنا القادمة.",

//       mainResponsibilities: json['mainResponsibilities'] != null
//           ? List<String>.from(json['mainResponsibilities'])
//           : [],

//       requirements: json['requirements'] != null
//           ? List<String>.from(json['requirements'])
//           : [],

//       benefits:
//           json['benefits'] != null ? List<String>.from(json['benefits']) : [],

//       additionalDetails:
//           json['additionalDetails'] ?? "لا تتوفر تفاصيل إضافية حالياً.",

//       isCvRequired: json['isCvRequired'] ?? true,
//       isGitHubOrPortfolioRequired: json['isGitHubOrPortfolioRequired'] ?? false,
//       isSalaryRequired: json['isSalaryRequired'] ?? false,
//     );
//   }
// // }
// //---------------------
// class CompaniesPostModel {
//   final int? id;
//   final String? companyName;
//   final int? companyId;
//   final String? jobTitle;
//   final String? logo;
//   final String? time;
//   final String? image;
//   final int? applicants;
//   final String? content;
//   final List<String>? mainResponsibilities;
//   final List<String>? requirements;
//   final List<String>? benefits;
//   final String? additionalDetails;
//   final bool? isCvRequired;
//   final bool? isGitHubOrPortfolioRequired;
//   final bool? isSalaryRequired;

//   CompaniesPostModel({
//     this.id,
//     this.companyName,
//     this.companyId,
//     this.jobTitle,
//     this.logo,
//     this.time,
//     this.image,
//     this.applicants,
//     this.content,
//     this.mainResponsibilities,
//     this.requirements,
//     this.benefits,
//     this.additionalDetails,
//     this.isCvRequired,
//     this.isGitHubOrPortfolioRequired,
//     this.isSalaryRequired,
//   });

//   factory CompaniesPostModel.fromJson(Map<String, dynamic> json) {
//     final company = json['company'] as Map<String, dynamic>?;

//     // 1. التحقق الآمن من المسؤوليات (mainResponsibilities) وتعيين قيم افتراضية مهنية عند خلوها
//     final rawResponsibilities = json['mainResponsibilities'];
//     final List<String> responsibilitiesList = (rawResponsibilities != null &&
//             rawResponsibilities is List &&
//             rawResponsibilities.isNotEmpty)
//         ? List<String>.from(rawResponsibilities)
//         : [
//             "المساهمة في بناء وتطوير برمجيات عالية الجودة والأداء.",
//             "العمل والتعاون بروح الفريق مع المطورين والمصممين لتحسين تجربة المستخدم.",
//             "كتابة أكواد برمجية نظيفة، آمنة، وقابلة للتوسيع والصيانة مستقبلاً."
//           ];

//     // 2. التحقق الآمن من المتطلبات (requirements) وتعيين قيم افتراضية مهنية عند خلوها
//     final rawRequirements = json['requirements'];
//     final List<String> requirementsList = (rawRequirements != null &&
//             rawRequirements is List &&
//             rawRequirements.isNotEmpty)
//         ? List<String>.from(rawRequirements)
//         : [
//             "خبرة عملية سابقة ومعرفة جيدة بالتقنيات المطلوبة للوظيفة.",
//             "القدرة على التفكير التحليلي وحل المشكلات التقنية بكفاءة.",
//             "امتلاك مهارات تواصل ممتازة والقدرة على التعلم الذاتي المستمر."
//           ];

//     // 3. التحقق الآمن من الميزات (benefits) وتعيين قيم افتراضية مهنية عند خلوها
//     final rawBenefits = json['benefits'];
//     final List<String> benefitsList =
//         (rawBenefits != null && rawBenefits is List && rawBenefits.isNotEmpty)
//             ? List<String>.from(rawBenefits)
//             : [
//                 "بيئة عمل احترافية، مرنة، ومحفزة تدعم الإبداع والتطور.",
//                 "رواتب ومكافآت مجزية وتنافسية تتناسب مع الخبرة والكفاءة.",
//                 "فرص مستمرة لتطوير المهارات التقنية والنمو المهني داخل الشركة."
//               ];

//     return CompaniesPostModel(
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
//       companyName: company?['name'] ?? "اسم الشركة غير محدد",
//       companyId: company?['id'] != null
//           ? int.tryParse(company!['id'].toString())
//           : null,
//       jobTitle: json['job_name'] ?? "عنوان الوظيفة غير محدد",
//       logo: company?['image'] ??
//           company?['logo'] ??
//           "https://cdn-icons-png.flaticon.com/512/732/732221.png",
//       time: json['since'] ?? "منذ مدة",
//       image: json['image'] ??
//           "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
//       applicants: json['applicants_count'] != null
//           ? int.tryParse(json['applicants_count'].toString())
//           : 0,
//       // content: json['content'] ??
//       content: json['description'] ??
//           "نبحث عن محترفين ومطورين شغوفين للانضمام إلى فريق العمل والمساهمة في مشاريعنا القادمة.",

//       // إسناد القوائم المعالجة بالأعلى
//       mainResponsibilities: responsibilitiesList,
//       requirements: requirementsList,
//       benefits: benefitsList,

//       additionalDetails:
//           // json['additionalDetails'] ?? "لا تتوفر تفاصيل إضافية حالياً.",
//           json['additional_details'] ?? "لا تتوفر تفاصيل إضافية حالياً.",
//       isCvRequired: json['isCvRequired'] ?? true,
//       isGitHubOrPortfolioRequired: json['isGitHubOrPortfolioRequired'] ?? false,
//       isSalaryRequired: json['isSalaryRequired'] ?? false,
//     );
//   }
// }
//--------------
class CompaniesPostModel {
  final int? id;
  final String? companyName;
  final int? companyId;
  final String? jobTitle;
  final String? logo;
  final String? time;
  final String? image;
  final int? applicants;
  final String? content;
  final List<String>? mainResponsibilities;
  final List<String>? requirements;
  final List<String>? benefits;
  final String? additionalDetails;
  final bool? isCvRequired;
  final bool? isGitHubOrPortfolioRequired;
  final bool? isSalaryRequired;

  CompaniesPostModel({
    this.id,
    this.companyName,
    this.companyId,
    this.jobTitle,
    this.logo,
    this.time,
    this.image,
    this.applicants,
    this.content,
    this.mainResponsibilities,
    this.requirements,
    this.benefits,
    this.additionalDetails,
    this.isCvRequired,
    this.isGitHubOrPortfolioRequired,
    this.isSalaryRequired,
  });

  factory CompaniesPostModel.fromJson(Map<String, dynamic> json) {
    final company = json['company'] as Map<String, dynamic>?;

    // 1. استخراج المهام الرئيسية (mainResponsibilities) ديناميكياً من حقول task1 إلى task5
    final List<String> responsibilitiesList = [];
    for (int i = 1; i <= 5; i++) {
      final task = json['task$i'];
      if (task != null && task.toString().trim().isNotEmpty) {
        responsibilitiesList.add(task.toString());
      }
    }
    if (responsibilitiesList.isEmpty) {
      responsibilitiesList.addAll([
        "المساهمة في بناء وتطوير برمجيات عالية الجودة والأداء.",
        "العمل والتعاون بروح الفريق مع المطورين والمصممين لتحسين تجربة المستخدم.",
        "كتابة أكواد برمجية نظيفة، آمنة، وقابلة للتوسيع والصيانة مستقبلاً."
      ]);
    }

    // 2. استخراج المتطلبات (requirements) ديناميكياً من حقول req1 إلى req5
    final List<String> requirementsList = [];
    for (int i = 1; i <= 5; i++) {
      final req = json['req$i'];
      if (req != null && req.toString().trim().isNotEmpty) {
        requirementsList.add(req.toString());
      }
    }
    if (requirementsList.isEmpty) {
      requirementsList.addAll([
        "خبرة عملية سابقة ومعرفة جيدة بالتقنيات المطلوبة للوظيفة.",
        "القدرة على التفكير التحليلي وحل المشكلات التقنية بكفاءة.",
        "امتلاك مهارات تواصل ممتازة والقدرة على التعلم الذاتي المستمر."
      ]);
    }

    // 3. استخراج الميزات (benefits) ديناميكياً من حقول feature1 إلى feature5
    final List<String> benefitsList = [];
    for (int i = 1; i <= 5; i++) {
      final feature = json['feature$i'];
      if (feature != null && feature.toString().trim().isNotEmpty) {
        benefitsList.add(feature.toString());
      }
    }
    if (benefitsList.isEmpty) {
      benefitsList.addAll([
        "بيئة عمل احترافية، مرنة، ومحفزة تدعم الإبداع والتطور.",
        "رواتب ومكافآت مجزية وتنافسية تتناسب مع الخبرة والكفاءة.",
        "فرص مستمرة لتطوير المهارات التقنية والنمو المهني داخل الشركة."
      ]);
    }

    return CompaniesPostModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      companyName: company?['name'] ?? "اسم الشركة غير حدد",
      companyId: json['company_id'] != null
          ? int.tryParse(json['company_id'].toString())
          : (company?['id'] != null
              ? int.tryParse(company!['id'].toString())
              : null),
      jobTitle: json['job_name'] ?? "عنوان الوظيفة غير محدد",
      logo: company?['image'] ??
          company?['logo'] ??
          "https://cdn-icons-png.flaticon.com/512/732/732221.png",
      // time: json['since'] ?? "منذ مدة",
      time: _formatFriendlyTime(json['since']?.toString()),
      image: json['image'] ??
          "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
      applicants: json['applicants_count'] != null
          ? int.tryParse(json['applicants_count'].toString())
          : 0,

      // التوافق مع حقلي الوصف والمحتوى
      content: json['description'] ??
          json['content'] ??
          "نبحث عن محترفين ومطورين شغوفين للانضمام إلى فريق العمل والمساهمة في مشاريعنا القادمة.",

      mainResponsibilities: responsibilitiesList,
      requirements: requirementsList,
      benefits: benefitsList,

      additionalDetails: json['additional_details'] ??
          json['additionalDetails'] ??
          "لا تتوفر تفاصيل إضافية حالياً.",

      // مطابقة المتغيرات المنطقية للطلب مع السيرفر
      isCvRequired: json['resume_required'] ?? json['isCvRequired'] ?? true,
      isGitHubOrPortfolioRequired: json['github_required'] ??
          json['isGitHubOrPortfolioRequired'] ??
          false,
      isSalaryRequired:
          json['expected_salary_required'] ?? json['isSalaryRequired'] ?? false,
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
