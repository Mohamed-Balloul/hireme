// class CompanyProfileModel {
//   //images
//   final String logoUrl; // رابط اللوجو
//   final String coverUrl; // صورة الغلاف (خلفية البروفايل)
//   final List<String> officeGallery; // صور من داخل الشركة

//   //General Informations
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? description;
//   final String website; // الموقع الرسمي
//   final String
//       industry; // مجال الشركة (مثلاً: تكنولوجيا معلومات، تجارة إلكترونية)

//   // Statistical Informations
//   final int foundedYear; // سنة التأسيس
//   final String companySize; // حجم الشركة (مثلاً: 50-100 موظف)
//   final String? headquarters;
//   final double rating; // تقييم الشركة
//   final List<String> techStack; // التقنيات المستخدمة (هام جداً للمطورين)
//   final List<String> socialMediaLinks; // روابط التواصل

//   CompanyProfileModel({
//     this.name,
//     this.email,
//     this.phone,
//     this.description,
//     this.headquarters,
//     required this.logoUrl,
//     required this.coverUrl,
//     required this.website,
//     required this.industry,
//     required this.companySize,
//     required this.foundedYear,
//     this.rating = 0.0,
//     this.techStack = const [],
//     this.socialMediaLinks = const [],
//     this.officeGallery = const [],
//   });
//   //--هون
// }
// class CompanyProfileModel {
//   //images
//   final String logoUrl; // رابط اللوجو
//   final String coverUrl; // صورة الغلاف (خلفية البروفايل)
//   final List<String> officeGallery; // صور من داخل الشركة

//   //General Informations
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? description;
//   final String website; // الموقع الرسمي
//   final String
//       industry; // مجال الشركة (مثلاً: تكنولوجيا معلومات، تجارة إلكترونية)

//   // Statistical Informations
//   final int foundedYear; // سنة التأسيس
//   final String companySize; // حجم الشركة (مثلاً: 50-100 موظف)
//   final String? headquarters; // المقر الرئيسي
//   final double rating; // تقييم الشركة
//   final List<String> techStack; // التقنيات المستخدمة (هام جداً للمطورين)
//   final List<String> socialMediaLinks; // روابط التواصل

//   // New fields from backend
//   final int? id;
//   final String? type;
//   final int? profileId;
//   final int? userId;
//   final int? employeesCount;

//   CompanyProfileModel({
//     this.id,
//     this.type,
//     this.profileId,
//     this.userId,
//     this.employeesCount,
//     this.name,
//     this.email,
//     this.phone,
//     this.description,
//     this.headquarters,
//     required this.logoUrl,
//     required this.coverUrl,
//     required this.website,
//     required this.industry,
//     required this.companySize,
//     required this.foundedYear,
//     this.rating = 0.0,
//     this.techStack = const [],
//     this.socialMediaLinks = const [],
//     this.officeGallery = const [],
//   });

//   factory CompanyProfileModel.fromJson(Map<String, dynamic> json) {
//     final data = json['data'] ?? {};
//     final profile = data['profile'] ?? {};

//     return CompanyProfileModel(
//       id: data['id'] ?? 0,
//       type: data['type'] ?? '',
//       profileId: profile['id'] ?? 0,
//       userId: profile['user_id'] ?? 0,
//       employeesCount: profile['employees_count'] ?? 0,
//       name: data['username'] ?? '',
//       email: data['email'] ?? '',
//       phone: '',
//       description: '',
//       headquarters: '',
//       logoUrl: '',
//       coverUrl: '',
//       website: '',
//       industry: '',
//       companySize: profile['employees_count']?.toString() ?? '',
//       foundedYear: profile['started_at'] != null
//           ? int.tryParse(profile['started_at'].toString().split('-').first) ?? 0
//           : 0,
//       rating: 0.0,
//       techStack: const [],
//       socialMediaLinks: const [],
//       officeGallery: const [],
//     );
//   }
// }
//------
class CompanyProfileModel {
  //images
  final String logoUrl; // رابط اللوجو
  final String coverUrl; // صورة الغلاف (خلفية البروفايل)
  final List<String> officeGallery; // صور من داخل الشركة
//--//
  //General Informations
  final String? name;
  final String? email;
  final String? phone;
  final String? description;
  final String website; // الموقع الرسمي
  final String
      industry; // مجال الشركة (مثلاً: تكنولوجيا معلومات، تجارة إلكترونية)

  // Statistical Informations
  final int foundedYear; // سنة التأسيس
  final int companySize; // حجم الشركة (مثلاً: 50-100 موظف)
  final String? headquarters; // المقر الرئيسي
  final double rating; // تقييم الشركة
  final List<String> techStack; // التقنيات المستخدمة (هام جداً للمطورين)
  final List<String> socialMediaLinks; // روابط التواصل

  // New fields from backend
  final int? id;
  final String? type;
  final int? profileId;
  final int? userId;
  final int? employeesCount;

  CompanyProfileModel({
    this.id,
    this.type,
    this.profileId,
    this.userId,
    this.employeesCount,
    this.name,
    this.email,
    this.phone,
    this.description,
    this.headquarters,
    required this.logoUrl,
    required this.coverUrl,
    required this.website,
    required this.industry,
    required this.companySize,
    required this.foundedYear,
    this.rating = 0.0,
    this.techStack = const [],
    this.socialMediaLinks = const [],
    this.officeGallery = const [],
  });

  // factory CompanyProfileModel.fromJson(Map<String, dynamic> rawJson) {
  //   // خطوة أمان: التحقق مما إذا تم تمرير الاستجابة الكاملة أو كائن data الداخلي مباشرة
  //   final Map<String, dynamic> json =
  //       (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

  //   final profile = json['profile'] as Map<String, dynamic>?;

  //   // 1. تجميع المهارات/التقنيات من الحقول الفردية tech1, tech2, tech3
  //   List<String> compiledTechStack = [];
  //   if (profile != null) {
  //     if (profile['tech1'] != null &&
  //         profile['tech1'].toString().trim().isNotEmpty) {
  //       compiledTechStack.add(profile['tech1'].toString());
  //     }
  //     if (profile['tech2'] != null &&
  //         profile['tech2'].toString().trim().isNotEmpty) {
  //       compiledTechStack.add(profile['tech2'].toString());
  //     }
  //     if (profile['tech3'] != null &&
  //         profile['tech3'].toString().trim().isNotEmpty) {
  //       compiledTechStack.add(profile['tech3'].toString());
  //     }
  //   }
  //   if (compiledTechStack.isEmpty) {
  //     compiledTechStack = [
  //       "Laravel",
  //       "React",
  //       "Flutter"
  //     ]; // قيمة افتراضية تناسب تخصصات الشركات
  //   }

  //   // 2. معالجة روابط السوشيال ميديا بشكل دفاعي صارم لتجنب كراش الفهرسة بالواجهة
  //   List<String> socialLinks = [];
  //   if (json['social_links'] is List) {
  //     socialLinks = List<String>.from(json['social_links']);
  //   }
  //   // فرض وجود رابطين كحد أدنى لحماية الواجهة من كراش الـ Index
  //   while (socialLinks.length < 2) {
  //     if (socialLinks.isEmpty) {
  //       socialLinks.add("https://linkedin.com");
  //     } else {
  //       socialLinks.add("https://github.com");
  //     }
  //   }

  //   // 3. معالجة سنة التأسيس من حقل "started_at"
  //   int parsedFoundedYear = 2020;
  //   if (profile?['started_at'] != null) {
  //     final dateParts = profile!['started_at'].toString().split('-');
  //     if (dateParts.isNotEmpty) {
  //       parsedFoundedYear = int.tryParse(dateParts.first) ?? 2020;
  //     }
  //   }

  //   return CompanyProfileModel(
  //     id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
  //     type: json['type'] ?? "company",
  //     profileId: profile?['id'] != null
  //         ? int.tryParse(profile!['id'].toString())
  //         : null,
  //     userId: profile?['user_id'] != null
  //         ? int.tryParse(profile!['user_id'].toString())
  //         : null,
  //     employeesCount: profile?['employees_count'] != null
  //         ? int.tryParse(profile!['employees_count'].toString())
  //         : 50,

  //     // ربط الحقول العامة والتحقق من القيم الفارغة
  //     name: json['username'] ?? "اسم الشركة غير متوفر",
  //     email: json['email'] ?? "لا يوجد بريد إلكتروني",
  //     phone: json['phone_number'] ?? "لا يوجد رقم هاتف",
  //     description: json['description'] ??
  //         "شركة رائدة متخصصة في توفير وتطوير أفضل الحلول التقنية المبتكرة للمؤسسات والمطورين.",

  //     logoUrl: json['avatar'] ??
  //         "https://cdn-icons-png.flaticon.com/512/3612/3612246.png", // لوجو افتراضي للشركة
  //     coverUrl: json['cover_image'] ??
  //         "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop", // غلاف افتراضي

  //     website: json['website'] ?? "https://example.com",
  //     industry: json['industry'] ?? "تكنولوجيا المعلومات والبرمجيات",
  //     companySize: profile?['employees_count'] != null
  //         ? "${profile!['employees_count']} موظف"
  //         : "50 موظف",

  //     foundedYear: parsedFoundedYear,
  //     rating: json['rating'] != null
  //         ? double.tryParse(json['rating'].toString()) ?? 4.5
  //         : 4.5,

  //     techStack: compiledTechStack,
  //     socialMediaLinks: socialLinks,
  //     officeGallery: json['office_gallery'] != null
  //         ? List<String>.from(json['office_gallery'])
  //         : [],
  //   );
  // }
  // استبدل كود منشئ الـ fromJson داخل كلاس CompanyProfileModel في ملف الموديل بهذا الكود:

  factory CompanyProfileModel.fromJson(Map<String, dynamic> rawJson) {
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    final profile = json['profile'] as Map<String, dynamic>?;

    // 1. تجميع المهارات/التقنيات من الحقول الفردية tech1, tech2, tech3
    List<String> compiledTechStack = [];
    if (profile != null) {
      if (profile['tech1'] != null &&
          profile['tech1'].toString().trim().isNotEmpty) {
        compiledTechStack.add(profile['tech1'].toString());
      }
      if (profile['tech2'] != null &&
          profile['tech2'].toString().trim().isNotEmpty) {
        compiledTechStack.add(profile['tech2'].toString());
      }
      if (profile['tech3'] != null &&
          profile['tech3'].toString().trim().isNotEmpty) {
        compiledTechStack.add(profile['tech3'].toString());
      }
    }
    if (compiledTechStack.isEmpty) {
      compiledTechStack = ["--"];
    }

    List<String> socialLinks = [];
    if (json['social_links'] is List) {
      socialLinks = List<String>.from(json['social_links']);
    }
    while (socialLinks.length < 2) {
      if (socialLinks.isEmpty) {
        socialLinks.add("https://linkedin.com");
      } else {
        socialLinks.add("https://github.com");
      }
    }

    int parsedFoundedYear = 2020;
    if (profile?['started_at'] != null) {
      final dateParts = profile!['started_at'].toString().split('-');
      if (dateParts.isNotEmpty) {
        parsedFoundedYear = int.tryParse(dateParts.first) ?? 2020;
      }
    }

    // --- المنطق الجديد والمحمي لتحويل روابط اللوجو والغلاف النسبية لروابط كاملة ---
    final String? rawAvatar = json['avatar'];
    String fullAvatar =
        "https://cdn-icons-png.flaticon.com/512/3612/3612246.png";

    if (rawAvatar != null && rawAvatar.isNotEmpty) {
      fullAvatar = rawAvatar.startsWith('http')
          ? rawAvatar
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawAvatar"; // تعديل الرابط ليتوافق مع لارافيل
    }

    final String? rawCover = json['cover_image'];
    String fullCover =
        "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop";

    if (rawCover != null && rawCover.isNotEmpty) {
      fullCover = rawCover.startsWith('http')
          ? rawCover
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawCover";
    }
    // ---------------------------------------------------------------------------------

    return CompanyProfileModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      type: json['type'] ?? "company",
      profileId: profile?['id'] != null
          ? int.tryParse(profile!['id'].toString())
          : null,
      userId: profile?['user_id'] != null
          ? int.tryParse(profile!['user_id'].toString())
          : null,
      employeesCount: profile?['employees_count'] != null
          ? int.tryParse(profile!['employees_count'].toString())
          : 50,

      name: json['username'] ?? "اسم الشركة غير متوفر",
      email: json['email'] ?? "لا يوجد بريد إلكتروني",
      phone: json['phone_number'] ?? "لا يوجد رقم هاتف",
      description: json['description'] ??
          "شركة رائدة متخصصة في توفير وتطوير أفضل الحلول التقنية المبتكرة للمؤسسات والمطورين.",

      logoUrl: fullAvatar, // تمرير الرابط الكامل الجديد
      coverUrl: fullCover, // تمرير الرابط الكامل الجديد

      website: json['website'] ?? "https://example.com",
      industry: json['industry'] ?? "تكنولوجيا المعلومات والبرمجيات",
      companySize: profile?['employees_count'] != null
          ? profile!['employees_count']
          : 50,
      // companySize: profile?['employees_count'] != null
      //     ? "${profile!['employees_count']} موظف"
      //     : "50 موظف",

      foundedYear: parsedFoundedYear,
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString()) ?? 4.5
          : 4.5,

      techStack: compiledTechStack,
      socialMediaLinks: socialLinks,
      officeGallery: json['office_gallery'] != null
          ? List<String>.from(json['office_gallery'])
          : [],
    );
  }
}
