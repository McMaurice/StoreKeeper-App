class ProductModel {
  final int? id;
  final String name;
  final String description;
  final int quantity;
  final int price;
  final String imagePath;
  final String status;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imagePath,
    required this.status,
  });
}
