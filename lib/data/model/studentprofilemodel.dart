// class StudentProfileModel {
//   // 1 General Informations
//   final String? cover;
//   final String? image;
//   final String? name;
//   final String? jobLabel;
//   final String? email;
//   final String? phone;
//   final String? bio;
//   final double? rating;
//   // 2 Statistical Info
//   final String? city;
//   final int? hourlySalary;
//   final int? experienceYears;
//   final List<String>? skils;
//   final String? github;
//   final String? linkedIn;
//   // 3 Education Info
//   final Map<String, dynamic>? educationInfo;
//   // 4 Work Experiences || الخبرة المهنية
//   final List<Map<String, dynamic>>? workExperiences;

//   StudentProfileModel({
//     // General Informations
//     this.cover,
//     this.image,
//     this.name,
//     this.jobLabel,
//     this.email,
//     this.phone,
//     this.bio,
//     this.rating,
//     // Statistical Info
//     this.city,
//     this.hourlySalary,
//     this.experienceYears,
//     this.skils,
//     this.github,
//     this.linkedIn,
//     // Education Info
//     this.educationInfo,
//     // Work Experiences || الخبرة المهنية
//     this.workExperiences,
//   });
// }

//-------------
// class StudentProfileModel {
//   // 1 General Informations
//   final int? id;
//   final String? image;
//   final String? cover;
//   final String? name;
//   final String? email;
//   final String? jobLabel;
//   final String? phone;
//   final String? bio;
//   final double? rating;
//   // 2 Statistical Info
//   // أضفنا بقية الحقول التي قد لا تظهر في عينة الـ API حالياً لتجنب الخطأ
//   final String? city;
//   final int? hourlySalary;
//   final int? experienceYears;
//   final List<String>? skils;
//   final String? github;
//   final String? linkedIn;
//   // 3 Education Info
//   final Map<String, dynamic>? educationInfo;
//   // 4 Work Experiences || الخبرة المهنية
//   final List<Map<String, dynamic>>? workExperiences;

//   StudentProfileModel({
//     this.id,
//     this.image,
//     this.cover,
//     this.name,
//     this.email,
//     this.jobLabel,
//     this.phone,
//     this.bio,
//     this.rating,
//     // Statistical Info
//     this.city,
//     this.hourlySalary,
//     this.experienceYears,
//     this.skils,
//     this.github,
//     this.linkedIn,
//     // Education Info
//     this.educationInfo,
//     // Work Experiences || الخبرة المهنية
//     this.workExperiences,
//   });

//   factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
//     return StudentProfileModel(
//       id: json['id'],
//       name: json['username'], // الباك يرسله username
//       email: json['email'],
//       phone: json['phone'] ?? "0931499508",
//       rating: json['rating'] ?? 2.3,

//       // الحقول التالية سنضع لها قيم افتراضية إذا لم يرسلها الباك حالياً
//       bio: json['profile']?['bio'] ?? "لا توجد نبذة تعريفية",
//       image: json['profile']?['image'] ??
//           'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop',
//       cover: json['profile']?['cover'] ??
//           'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop',
//       // Statistical Info
//       city: json['profile']?['city'] ?? "لا توجد مدينة",
//       hourlySalary: json['profile']?['hourly_salary'] ?? 0,
//       experienceYears: json['profile']?['experience_years'] ?? 0,
//       github: json['profile']?['github'] ?? "لا توجد حساب GitHub",
//       linkedIn: json['profile']?['linkedin'] ?? "لا توجد حساب LinkedIn",
//       skils: json['profile']?['skills'] != null
//           ? List<String>.from(json['profile']['skills'])
//           : [],
//       // Education Info
//       educationInfo: json['profile']?['education'] ?? {},
//       // Work Experiences || الخبرة المهنية
//       workExperiences: json['profile']?['experience'] != null
//           ? List<Map<String, dynamic>>.from(json['profile']['experience'])
//           : [],
//     );
//   }
// }
//--------------------------------------------------
//*********************************************** */
class StudentProfileModel {
  // 1 General Informations
  final int? id;
  final String? image;
  final String? cover;
  final String? name;
  final String? email;
  final String? jobLabel;
  final String? phone;
  final String? bio;
  final double? rating;

  // 2 Statistical Info
  final String? city;
  final int? hourlySalary;
  final int? experienceYears;
  final List<String>?
      skils; // تم الإبقاء على الاسم المكتوب بنفس التهجئة لمنع الأخطاء في الواجهة
  final String? github;
  final String? linkedIn;

  // 3 Education Info
  final Map<String, dynamic>? educationInfo;

  // 4 Work Experiences || الخبرة المهنية
  final List<Map<String, dynamic>>? workExperiences;

  StudentProfileModel({
    this.id,
    this.image,
    this.cover,
    this.name,
    this.email,
    this.jobLabel,
    this.phone,
    this.bio,
    this.rating,
    // Statistical Info
    this.city,
    this.hourlySalary,
    this.experienceYears,
    this.skils,
    this.github,
    this.linkedIn,
    // Education Info
    this.educationInfo,
    // Work Experiences
    this.workExperiences,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> rawJson) {
    // خطوة أمان: إذا تم تمرير الاستجابة الكاملة للـ API بدلاً من الكائن 'data' الداخلي،
    // فسيقوم الموديل بالوصول تلقائياً إلى 'data' لتجنب الفشل في التحليل.
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    final profile = json['profile'] as Map<String, dynamic>?;

    // 1. تحويل تكلفة الساعة (hour_cost) بأمان من نص (String) إلى رقم صحيح (int) كما هو متوقع في واجهتك
    int? parsedHourlySalary;
    if (profile != null && profile['hour_cost'] != null) {
      parsedHourlySalary =
          double.tryParse(profile['hour_cost'].toString())?.toInt();
    }

    // 2. تجميع المهارات (skils) من حقول التقنيات الفردية tech1, tech2, tech3 التي يرسلها الباك
    List<String> skillsList = [];
    if (profile != null) {
      if (profile['tech1'] != null &&
          profile['tech1'].toString().trim().isNotEmpty) {
        skillsList.add(profile['tech1'].toString());
      }
      if (profile['tech2'] != null &&
          profile['tech2'].toString().trim().isNotEmpty) {
        skillsList.add(profile['tech2'].toString());
      }
      if (profile['tech3'] != null &&
          profile['tech3'].toString().trim().isNotEmpty) {
        skillsList.add(profile['tech3'].toString());
      }
    }
    if (skillsList.isEmpty) {
      skillsList = ["Laravel", "React"]; // قيمة افتراضية عند عدم توفر تقنيات
    }

    // 3. إعادة بناء خريطة التعليم (educationInfo) لتتوافق مع ما تطلبه الواجهة في تطبيقك
    final Map<String, dynamic> eduMap = {
      'isGraduated': profile?['is_graduated'] ??
          true, // افتراضياً تم التخرج، أو يمكنك استخدام حقل مخصص إذا وفره الباك لاحقاً
      'college': profile?['college'] ?? "كلية غير محددة",
      'university': profile?['university'] ??
          "جامعة القاهرة", // الباك يرسل الكلية فقط حالياً، فوضعنا قيمة افتراضية للجامعة لتفادي الخطأ
    };

    return StudentProfileModel(
      id: json['id'],
      name: json['username'] ?? "مستخدم جديد", // تم ربطها بـ username
      email: json['email'] ?? "لا يوجد بريد إلكتروني",
      phone: json['phone_number'] ??
          "0931499508", // تم ربطها بـ phone_number الوارد من الباك
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : 4.5,
      bio: json['description'] ??
          "لا توجد نبذة تعريفية حالياً.", // تم ربطها بـ description الوارد من الباك
      image: json['avatar'] ??
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop', // تم ربطها بـ avatar
      cover: json['cover_image'] ??
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop', // تم ربطها بـ cover_image

      // Statistical Info
      city: profile?['address'] ??
          "مكان الإقامة غير محدد", // تم ربطها بـ address الوارد في الكائن الفرعي profile
      jobLabel: profile?['title'] ??
          "مطور برمجيات", // تم ربطها بـ title الوارد في الكائن الفرعي profile
      hourlySalary: parsedHourlySalary ?? 0,
      experienceYears: profile?['experience_years'] ?? 0,
      github: profile?['github'] ?? "https://github.com",
      linkedIn: profile?['linkedin'] ?? "https://linkedin.com",
      skils: skillsList,

      // Education Info
      educationInfo: eduMap,

      // Work Experiences || الخبرة المهنية
      workExperiences: (profile != null && profile['experience'] != null)
          ? List<Map<String, dynamic>>.from(profile['experience'])
          : [], // مصفوفة فارغة بشكل افتراضي في حال عدم وجود خبرات بالباك لمنع كراش الواجهة
    );
  }
}
