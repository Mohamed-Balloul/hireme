// class CustomerProfileModel {
//   // 1 General Informations
//   final String? id;
//   final String? cover;
//   final String image;
//   final String? name;
//   final String? jobLabel;
//   final String? email;
//   final String? phone;
//   final String? bio;
//   // 2 Statistical Info
//   final String? city;

//   final String? github;
//   final String? linkedIn;
//   // 3 Education Info
//   final Map<String, dynamic>? educationInfo;
//   // New fields from backend
//   final String? type;
//   final int? profileId;
//   final int? userId;

//   CustomerProfileModel({
// // General Informations
//     this.id,
//     this.cover,
//     required this.image,
//     this.name,
//     this.jobLabel,
//     this.email,
//     this.phone,
//     this.bio,
//     // Statistical Info
//     this.city,
//     this.github,
//     this.linkedIn,
//     // Education Info
//     this.educationInfo,
//     // New fields from backend
//     this.type,
//     this.profileId,
//     this.userId,
//   });
//   //
//   factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
//     final data = json['data'] ?? {};
//     final profile = data['profile'] ?? {};

//     return CustomerProfileModel(
//       id: data['id'] ?? 0,
//       type: data['type'] ?? '',
//       profileId: profile['id'] ?? 0,
//       userId: profile['user_id'] ?? 0,
//       name: data['username'] ?? '',
//       email: data['email'] ?? '',
//       jobLabel: profile['title'], // بيانات متداخلة
//       // Education Info
//       educationInfo: profile['education'] ?? {},
//       // Statistical Info
//       city: profile['city'] ?? '',
//       github: profile['github'] ?? "لا توجد حساب GitHub",
//       linkedIn: profile['linkedin'] ?? "لا توجد حساب LinkedIn",
//       phone: '',
//       bio: '',
//       image: '',
//       cover: '',
//     );
//   }
// }
//-----------
class CustomerProfileModel {
  // 1 General Informations
  final String? id;
  final String? cover;
  final String image; // غير قابلة لتكون null بالمنشئ المكتوب
  final String? name;
  final String? jobLabel;
  final String? email;
  final String? phone;
  final String? bio;

  // 2 Statistical Info
  final String? city;
  final String? github;
  final String? linkedIn;

  // 3 Education Info
  final Map<String, dynamic>? educationInfo;

  // New fields from backend
  final String? type;
  final int? profileId;
  final int? userId;

  CustomerProfileModel({
    this.id,
    this.cover,
    required this.image,
    this.name,
    this.jobLabel,
    this.email,
    this.phone,
    this.bio,
    // Statistical Info
    this.city,
    this.github,
    this.linkedIn,
    // Education Info
    this.educationInfo,
    // New fields from backend
    this.type,
    this.profileId,
    this.userId,
  });

  // factory CustomerProfileModel.fromJson(Map<String, dynamic> rawJson) {
  //   // خطوة أمان: التحقق مما إذا كان المدخل هو الاستجابة الكاملة أو كائن data الداخلي مباشرة
  //   final Map<String, dynamic> json =
  //       (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

  //   final profile = json['profile'] as Map<String, dynamic>?;

  //   // بناء خريطة التعليم برمجياً لتطابق متطلبات واجهتك وتمنع الأخطاء البرمجية
  //   final Map<String, dynamic> eduMap = {
  //     'isGraduated': true, // افتراضياً متخرج
  //     'college': profile?['college'] ??
  //         " Ain Shams University", // جلب الكلية من السيرفر أو وضع افتراضي
  //     'university':
  //         "جامعة عين شمس", // السيرفر لا يرسل اسم الجامعة فتم توفيره بشكل افتراضي آمن
  //   };

  //   return CustomerProfileModel(
  //     // تحويل رقم المعرّف (int) بأمان إلى نص (String) كما تم تعريفه في حقول الموديل الخاصة بك
  //     id: json['id']?.toString() ?? "0",
  //     type: json['type'] ?? "customer",
  //     profileId:
  //         profile?['id'] != null ? int.tryParse(profile!['id'].toString()) : 0,
  //     userId: profile?['user_id'] != null
  //         ? int.tryParse(profile!['user_id'].toString())
  //         : 0,

  //     // ربط اللوجو والغلاف مع قيم صور افتراضية صالحة لمنع توقف التطبيق في حال كانت null من السيرفر
  //     image: json['avatar'] ??
  //         "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
  //     cover: json['cover_image'] ??
  //         "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop",

  //     // البيانات الشخصية العامة والنبذة التعريفية
  //     name: json['username'] ?? "Client One",
  //     jobLabel: profile?['title'] ??
  //         "Product Owner", // المسمى الوظيفي متداخل داخل profile
  //     email: json['email'] ?? "client@example.com",
  //     phone: json['phone_number'] ?? "+201234567890",
  //     bio: json['description'] ??
  //         "أبحث عن مبرمجين ومطورين موهوبين للعمل على مشاريع برمجية جديدة.",

  //     // البيانات الجغرافية والتواصل الاجتماعي
  //     city: profile?['address'] ??
  //         "Cairo, Egypt", // ربط حقل city بـ address المتداخل في profile
  //     github: profile?['github'] ?? "https://github.com",
  //     linkedIn: profile?['linkedin'] ?? "https://linkedin.com",

  //     // إسناد خريطة التعليم المعالجة
  //     educationInfo: eduMap,
  //   );
  // }
  // استبدل كود منشئ الـ fromJson داخل كلاس CustomerProfileModel في ملف الموديل بهذا الكود:

  factory CustomerProfileModel.fromJson(Map<String, dynamic> rawJson) {
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    final profile = json['profile'] as Map<String, dynamic>?;

    final Map<String, dynamic> eduMap = {
      'isGraduated': true,
      'college': profile?['college'] ?? " Ain Shams University",
      'university': "جامعة عين شمس",
    };

    // --- المنطق الجديد والمحمي لتحويل روابط اللوجو والغلاف النسبية لروابط كاملة ---
    final String? rawAvatar = json['avatar'];
    String fullAvatar =
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop";

    if (rawAvatar != null && rawAvatar.isNotEmpty) {
      fullAvatar = rawAvatar.startsWith('http')
          ? rawAvatar
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawAvatar"; // تعديل الرابط ليتناسب مع سيرفرك
    }

    final String? rawCover = json['cover_image'];
    String fullCover =
        "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop";

    if (rawCover != null && rawCover.isNotEmpty) {
      fullCover = rawCover.startsWith('http')
          ? rawCover
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawCover";
    }
    // ---------------------------------------------------------------------------------

    return CustomerProfileModel(
      id: json['id']?.toString() ?? "0",
      type: json['type'] ?? "customer",
      profileId:
          profile?['id'] != null ? int.tryParse(profile!['id'].toString()) : 0,
      userId: profile?['user_id'] != null
          ? int.tryParse(profile!['user_id'].toString())
          : 0,

      image: fullAvatar, // تمرير الرابط الكامل الجديد
      cover: fullCover, // تمرير الرابط الكامل الجديد

      name: json['username'] ?? "Client One",
      jobLabel: profile?['title'] ?? "Product Owner",
      email: json['email'] ?? "client@example.com",
      phone: json['phone_number'] ?? "+201234567890",
      bio: json['description'] ??
          "أبحث عن مبرمجين ومطورين موهوبين للعمل على مشاريع برمجية جديدة.",

      city: profile?['address'] ?? "Cairo, Egypt",
      github: profile?['git_link'] ?? "https://github.com",
      linkedIn: profile?['linked_link'] ?? "https://linkedin.com",

      educationInfo: eduMap,
    );
  }
}
