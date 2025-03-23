class SliderModel {
  static const String baseUrl = 'https://ecomapi.nextgenbite.com/';

  final int id;
  final String title;
  final String thumbnail;

  SliderModel({required this.id, required this.title, required this.thumbnail});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
