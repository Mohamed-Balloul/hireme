class CompanyProfileModel {
  //images
  final String logoUrl; // رابط اللوجو
  final String coverUrl; // صورة الغلاف (خلفية البروفايل)
  final List<String> officeGallery; // صور من داخل الشركة

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
  final String companySize; // حجم الشركة (مثلاً: 50-100 موظف)
  final String? headquarters;
  final double rating; // تقييم الشركة
  final List<String> techStack; // التقنيات المستخدمة (هام جداً للمطورين)
  final List<String> socialMediaLinks; // روابط التواصل

  CompanyProfileModel({
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
}
