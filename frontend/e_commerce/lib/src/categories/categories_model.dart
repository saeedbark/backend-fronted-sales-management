class CategoryModel {
  final String name;
  final String image;
  final String description;

  CategoryModel({
    required this.name,
    required this.image,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}