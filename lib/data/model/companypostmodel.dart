class CompanyPostModel {
  final String? publisher;
  final String? jobTitle;
  final List<String>? mainResponsibilities;
  final List<String>? requirements;
  final List<String>? benefits;
  final String? additionalDetails;
  final bool? isCvRequired;
  final bool? isGitHubOrPortfolioRequired;
  final bool? isSalaryRequired;

  CompanyPostModel({
    this.publisher,
    this.jobTitle,
    this.mainResponsibilities,
    this.requirements,
    this.benefits,
    this.additionalDetails,
    this.isCvRequired,
    this.isGitHubOrPortfolioRequired,
    this.isSalaryRequired,
  });
}
