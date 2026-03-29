class CompaniesPostModel {
  final String? companyName;
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
    this.companyName,
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
}
