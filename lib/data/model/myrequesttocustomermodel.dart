class MyRequestToCustomerModel {
  final int? id;
  final String? publisher;
  final String? image;

  final String? serviceTitle;
  final int? requestState;

  MyRequestToCustomerModel({
    this.id,
    this.publisher,
    this.image,
    this.serviceTitle,
    this.requestState,
  });

  factory MyRequestToCustomerModel.fromJson(Map<String, dynamic> json) {
    return MyRequestToCustomerModel(
      id: json['id'],
      publisher: json['publisher'],
      image: json['image'],
      serviceTitle: json['service_title'] ?? json['serviceTitle'],
      requestState: json['request_state'] ?? json['requestState'],
    );
  }
}
