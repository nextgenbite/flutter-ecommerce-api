import 'cart_item.dart';

class Cart {
  final String? guestId;
  final int? userId;
  final int id;
  final double subtotal;
  final double total;
  final double weight;
  final String createdAt;
  final String updatedAt;
  final List<CartItem> items;

  Cart({
    required this.id,
    this.guestId,
    this.userId,
    required this.subtotal,
    required this.total,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      guestId: json['guest_id'],
      userId: json['user_id'],
      subtotal:
          double.tryParse(json['subtotal'].toString()) ??
          0.0, // Convert to double safely
      total:
          double.tryParse(json['total'].toString()) ??
          0.0, // Convert to double safely
      weight:
          double.tryParse(json['weight'].toString()) ??
          0.0, // Convert to double safely
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      items:
          json['items'] != null
              ? (json['items'] as List)
                  .map(
                    (item) => CartItem.fromJson(item as Map<String, dynamic>),
                  )
                  .toList()
              : [],
    );
  }
}
