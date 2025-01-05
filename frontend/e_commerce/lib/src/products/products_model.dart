class ProductModels {
  ProductModels({
    required this.id,
    required this.title,
    required this.price,
     this.description,
     this.category,
    required this.image,
     this.rating,
  });

  int id;
  String title;
  String price;
  String? description;
  Category? category;
  String image;
  Rating? rating;

  factory ProductModels.fromJson(Map<String, dynamic> json) => ProductModels(
    id: json["id"],
    title: json["name"],
    price: json["price"],
    description: json["description"] ??'des',
    category:json["category"] != null ? categoryValues.map[json["category"]]! : Category.MEN_S_CLOTHING,
    image: json["image"],
    rating:json["rating"] != null? Rating.fromJson(json["rating"]): Rating(rate: 0.0, count: 0),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": categoryValues.reverse[category],
    "image": image,
    "rating": rating?.toJson(),
  };
}

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  double rate;
  int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}