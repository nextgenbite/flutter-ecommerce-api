// import 'dart:convert';

class HomepageModel {
  final List<SliderModel> sliders;
  final List<CategoryModel> categories;
  // final List<BrandModel> brands;
  final List<ProductModel> trends;
  // final List<ProductModel> latest;

  HomepageModel({
    required this.sliders,
    required this.categories,
    // required this.brands,
    required this.trends,
    // required this.latest,
  });

  factory HomepageModel.fromJson(Map<String, dynamic> json) {
    return HomepageModel(
      sliders:
          (json['sliders'] as List)
              .map((e) => SliderModel.fromJson(e))
              .toList(),
      categories:
          (json['categories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList(),
      // // brands:
      // //     (json['brands'] as List).map((e) => BrandModel.fromJson(e)).toList(),
      trends:
          (json['trends'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
      // latest:
      //     (json['latest'] as List)
      //         .map((e) => ProductModel.fromJson(e))
      //         .toList(),
    );
  }
}

class SliderModel {
  static const String baseUrl = 'https://ecomerce_lara_nuxt.test/';

  final int id;
  final String title;
  final String thumbnail;

  SliderModel({required this.id, required this.title, required this.thumbnail});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }
}

class CategoryModel {
  final int id;
  final String title;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.title,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      productCount: json['products_count'] ?? 0,
    );
  }
}

// class BrandModel {
//   final int id;
//   final String name;
//   final int productCount;

//   BrandModel({
//     required this.id,
//     required this.name,
//     required this.productCount,
//   });

//   factory BrandModel.fromJson(Map<String, dynamic> json) {
//     return BrandModel(
//       id: json['id'],
//       name: json['name'],
//       productCount: json['products_count'] ?? 0,
//     );
//   }
// }

class ProductModel {
  static const String baseUrl = 'https://ecomerce_lara_nuxt.test/';

  final int id;
  final String title;
  final double price;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] ?? 0.0).toDouble(),
      thumbnail:
          json['thumbnail'] ?? '', // Assuming at least one image is present
    );
  }
}
