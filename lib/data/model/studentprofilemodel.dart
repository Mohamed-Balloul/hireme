class StudentProfileModel {
  // 1 General Informations
  final String? cover;
  final String? image;
  final String? name;
  final String? jobLabel;
  final String? email;
  final String? phone;
  final String? bio;
  final double? rating;
  // 2 Statistical Info
  final String? city;
  final int? hourlySalary;
  final int? experienceYears;
  final List<String>? skils;
  final String? github;
  final String? linkedIn;
  // 3 Education Info
  final Map<String, dynamic>? educationInfo;
  // 4 Work Experiences || الخبرة المهنية
  final List<Map<String, dynamic>>? workExperiences;

  StudentProfileModel({
    // General Informations
    this.cover,
    this.image,
    this.name,
    this.jobLabel,
    this.email,
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
    // Work Experiences || الخبرة المهنية
    this.workExperiences,
  });
}
