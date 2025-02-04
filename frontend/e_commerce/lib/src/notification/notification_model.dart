class NotificationModel {
  final int productId;
  final String message;
  final int daysSinceAdded;
  final double price;
  final String deadlinePassedBy;
  final DateTime dateAdded;

  NotificationModel({
    required this.productId,
    required this.message,
    required this.daysSinceAdded,
    required this.price,
    required this.deadlinePassedBy,
    required this.dateAdded,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      productId: json['productId'],
      message: json['message'],
      daysSinceAdded: json['days_since_added'],
      price: json['price'],
      deadlinePassedBy: json['deadline_passed_by'],
      dateAdded: DateTime.parse(json['date_added']),
    );
  }
}