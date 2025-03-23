class Category {
  final int id;
  final String title;
  final String thumbnail;
  final int status;
  // final String createdAt;
  // final String updatedAt;
  Category({
    required this.id,
    required this.title,
    this.thumbnail = '',
    this.status = 0,
    // this.createdAt = '',
    // this.updatedAt = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'] ?? '',
      status: json['status'] ?? 0,
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
  }
}
