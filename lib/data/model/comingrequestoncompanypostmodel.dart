class ComingRequestOnCompanyPostModel {
  final String? name;

  final bool? isCvRequired;
  final bool? isGitHubOrPortfolioRequired;
  final bool? isSalaryRequired;

  ComingRequestOnCompanyPostModel({
    this.name,
    this.isCvRequired,
    this.isGitHubOrPortfolioRequired,
    this.isSalaryRequired,
  });
}
