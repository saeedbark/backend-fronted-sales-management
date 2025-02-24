import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/cart/cart_controller.dart';
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
      CartController cartController = Get.find<CartController>();

      if (cartController.productsMap.keys.isEmpty) {
        await cartController.loadCart();
      }

      List<CartItem> cartItems = cartController.productsMap.entries.map(
        (entry) {
          final product = entry.key;
          final quantity = entry.value;
          return CartItem(
            productId: product.id,
            quantity: quantity['quantity'],
            dateAdded: quantity['dateAdded'],
            price: product.price,
          );
        },
      ).toList();

      final notifications =
          await NotificationService().fetchOverdueNotifications(
        cartItems,
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

  void removeAllNotification() {
    notifications.clear();
  }
}
