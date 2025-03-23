class ShippingCost {
  final int id;
  final String title;
  final double cost;
  final int status;
  final String createdAt;
  final String updatedAt;

  ShippingCost({
    required this.id,
    required this.title,
    required this.cost,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShippingCost.fromJson(Map<String, dynamic> json) {
    return ShippingCost(
      id: json['id'],
      title: json['title'],
      cost:
          double.tryParse(json['cost'].toString()) ??
          0.0, // Convert to double safely
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
