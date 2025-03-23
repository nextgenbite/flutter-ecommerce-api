class Order {
  final String name;
  final String phone;
  final String address;
  final double shippingCost;
  final String paymentMethod;
  final List<Map<String, dynamic>> carts;

  Order({
    required this.name,
    required this.phone,
    required this.address,
    required this.shippingCost,
    required this.paymentMethod,
    required this.carts,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'shipping_cost': shippingCost,
      'payment_method': paymentMethod,
      'carts': carts,
    };
  }
}
