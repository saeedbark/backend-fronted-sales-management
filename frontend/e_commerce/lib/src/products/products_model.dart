class ProductModels {
  final int id;
  final String title;
  final double price;
  final String? description;
  final String? category;
  final String image;
  final Rating? rating;
  final DateTime? dateAdded;
  ProductModels({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    this.category,
    required this.image,
    this.rating,
    this.dateAdded,
  });

  factory ProductModels.fromJson(Map<String, dynamic> json) => ProductModels(
        id: json["id"],
        title: json["name"],
        price:double.tryParse(json["price"])??0.0 ,
        description: json["description"] ?? 'des',
        category: json["category"] ?? '',
        image: json["image"],
        rating: json["rating"] != null
            ? Rating.fromJson(json["rating"])
            : Rating(rate: 0.0, count: 0),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "image": image,
        "rating": rating?.toJson(),
      };
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble() ?? 3.0,
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
