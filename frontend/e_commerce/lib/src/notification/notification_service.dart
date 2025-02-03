import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';
import 'package:e_commerce/src/cart/cart_model.dart';
import 'package:get/get.dart';
import 'notification_model.dart';

class NotificationService extends GetxService {
  static const String _baseUrl = 'http://127.0.0.1:8000/';

  Future<List<NotificationModel>> fetchOverdueNotifications(
    List<CartItem> cartItems,
  ) async {
    try {
      // Convert cart items to JSON
      final cartItemsJson = cartItems.map((item) => item.toJson()).toList();

      final response = await DioHelper().post(
        '$_baseUrl${ApiPath.notification}',
        data: cartItemsJson,
        headers: {
          "Content-Type": "application/json",
        },
      );
      print('11111111111111111111111111111111111');
      if (response == null) {
        throw Exception('No response from server');
      }

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load notifications: ${response.statusMessage}');
      }

      return (response.data['overdue_items'] as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Notification service error: ${e.toString()}');
    }
  }
}
