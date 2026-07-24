class MyRequestToCompanyModel {
  final int? id;
  final String? publisher;
  final String? logo;
  final String? jobTitle;
  final int? orderState;

  MyRequestToCompanyModel({
    this.id,
    this.publisher,
    this.logo,
    this.jobTitle,
    this.orderState,
  });
  // إضافة منشئ json لتسهيل عملية التحويل
  factory MyRequestToCompanyModel.fromJson(Map<String, dynamic> json) {
    return MyRequestToCompanyModel(
      id: json['id'],
      publisher: json['publisher'],
      logo: json['logo'],
      // حقول لارافيل تكون غالباً snake_case، قمنا بتوقع الحالتين للاحتياط
      jobTitle: json['job_title'] ?? json['jobTitle'],
      orderState: json['order_state'] ?? json['orderState'],
    );
  }
}
