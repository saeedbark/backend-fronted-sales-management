

class CartItem {
  final int productId;
  int quantity;
  DateTime dateAdded;
  double price;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.dateAdded,
    required this.price,
  });

  // Factory constructor to create a CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['productId'],
        quantity: json['quantity'],
        dateAdded: DateTime.parse(json['dateAdded']),
        price: json['price'].toDouble(),
      );

  // Method to convert CartItem to JSON
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
        'dateAdded': dateAdded.toIso8601String(),
        'price': price,
      };
}
