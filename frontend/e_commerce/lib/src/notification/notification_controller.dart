import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/cart/cart_model.dart';
import 'package:e_commerce/src/notification/notification_model.dart';
import 'package:e_commerce/src/notification/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading(true);
      errorMessage('');
      final notifications =
          await NotificationService().fetchOverdueNotifications(
        [
          CartItem(
            productId: 1,
            quantity: 2,
            dateAdded: DateTime.parse('2024-02-20T10:00:00'),
            price: 19.99,
          ),
          CartItem(
            productId: 3,
            quantity: 1,
            dateAdded: DateTime.parse('2025-02-02T09:15:00'),
            price: 9.99,
          )
        ],
      );
      this.notifications.assignAll(notifications);
    } on AppException catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void removeNotification(int productId) {
    notifications.removeWhere((item) => item.productId == productId);
  }
}
