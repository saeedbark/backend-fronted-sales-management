import 'package:e_commerce/src/notification/notification_controller.dart';
import 'package:e_commerce/src/notification/notification_model.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadNotifications,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkColor : mainColor,
            ),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.red,
              ),
            ),
          );
        }

        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 90,
                  color: Colors.grey.shade400,
                ),
                Text(
                  'No pending notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Get.isDarkMode ? Colors.white : Colors.grey.shade600,
                  ),
                )
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
          itemBuilder: (context, index) => _buildNotificationItem(
            controller.notifications[index],
            controller,
          ),
        );
      }),
    );
  }

  Widget _buildNotificationItem(
    NotificationModel notification,
    NotificationController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        child: ListTile(
          leading: const Icon(Icons.notification_important, color: Colors.red),
          title: Text(
            notification.message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : blackColor,
            ),
          ),
          subtitle: Text(
            'Pending for ${notification.daysSinceAdded} days',
            style: TextStyle(
              color:
                  Get.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.clear),
            color: Colors.grey,
            onPressed: () =>
                controller.removeNotification(notification.productId),
          ),
        ),
      ),
    );
  }
}
