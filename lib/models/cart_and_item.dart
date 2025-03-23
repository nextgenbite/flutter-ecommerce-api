class CartItem {
  final int productId;
  final String name;
  final double price;
  final String thumbnail;
  final double weight;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.thumbnail,
    required this.weight,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      name: json['name'],
      price: (json['price'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'],
      weight: (json['weight'] ?? 0).toDouble(), // Handle null weight
      quantity: json['quantity'] ?? 1,
    );
  }
}

class Cart {
  List<CartItem> items;
  double subtotal;
  double weight;
  double shippingCost;
  double tax;
  double discount;
  double total;

  Cart({
    required this.items,
    required this.subtotal,
    required this.weight,
    required this.shippingCost,
    required this.tax,
    required this.discount,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as Map<String, dynamic>;
    List<CartItem> cartItems =
        itemList.entries
            .map((entry) => CartItem.fromJson(entry.value))
            .toList();

    return Cart(
      items: cartItems,
      subtotal: json['subtotal'].toDouble(),
      weight: json['weight'].toDouble(),
      shippingCost: json['shipping_cost'].toDouble(),
      tax: json['tax'].toDouble(),
      discount: json['discount'].toDouble(),
      total: json['total'].toDouble(),
    );
  }
}
