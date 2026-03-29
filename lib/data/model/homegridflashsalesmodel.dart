class HomeGridFlashSalesModel {
  final String? styleType;
  final String? fullLabel;
  final String? productDetalils;
  final String? image;
  final String? label;
  final String price;
  String? size;
  int quantity;

  HomeGridFlashSalesModel({
    this.styleType,
    this.fullLabel,
    this.productDetalils,
    this.image,
    required this.price,
    this.label,
    this.size,
    required this.quantity,
  });
}
