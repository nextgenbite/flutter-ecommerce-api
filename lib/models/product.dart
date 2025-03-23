class Product {
  static const String baseUrl = 'https://ecomapi.nextgenbite.com/';

  final int id;
  final String title;
  final double price;
  final double discount;
  final String thumbnail;
  final int stock;
  final String description;
  final List images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.thumbnail,
    required this.stock,
    required this.description,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      thumbnail: json['thumbnail'] ?? '', // Construct correct image URL
      stock: json['stock'] ?? 0, // Fix here
      description: json['description'] ?? '', // Fix here
      images: json['images'] ?? [], // Fix here
    );
  }

  // ✅ Add this method to convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "discount": discount,
      "thumbnail": thumbnail,
      "stock": stock,
      "description": description,
      "images": images, // Assuming this is a List of image URLs
    };
  }
}
