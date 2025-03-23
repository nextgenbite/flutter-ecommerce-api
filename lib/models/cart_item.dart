import 'product.dart';

class CartItem {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final double price;
  final double discount;
  final String createdAt;
  final String updatedAt;
  final Product product;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cart_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price:
          double.tryParse(json['subtotal'].toString()) ??
          0.0, // Convert to double safely
      discount: double.tryParse(json['discount'].toString()) ?? 0.0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  // ✅ Add this method to fix the 'toJson()' issue
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cart_id": cartId,
      "product_id": productId,
      "quantity": quantity,
      "price": price,
      "discount": discount,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "product": product.toJson(), // Ensure Product also has a toJson() method
    };
  }
}
