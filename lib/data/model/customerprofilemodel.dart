class CustomerProfileModel {
  // 1 General Informations
  final String? id;
  final String? cover;
  final String image;
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
// General Informations
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
  //
  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final profile = data['profile'] ?? {};

    return CustomerProfileModel(
      id: data['id'] ?? 0,
      type: data['type'] ?? '',
      profileId: profile['id'] ?? 0,
      userId: profile['user_id'] ?? 0,
      name: data['username'] ?? '',
      email: data['email'] ?? '',
      jobLabel: profile['title'], // بيانات متداخلة
      // Education Info
      educationInfo: profile['education'] ?? {},
      // Statistical Info
      city: profile['city'] ?? '',
      github: profile['github'] ?? "لا توجد حساب GitHub",
      linkedIn: profile['linkedin'] ?? "لا توجد حساب LinkedIn",
      phone: '',
      bio: '',
      image: '',
      cover: '',
    );
  }
}
