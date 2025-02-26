import 'package:e_commerce/src/notification/notification_controller.dart';
import 'package:e_commerce/src/widget/notification/empty.dart';
import 'package:e_commerce/src/widget/notification/error.dart';
import 'package:e_commerce/src/widget/notification/notification_card.dart';
import 'package:e_commerce/src/widget/notification/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    final theme = Theme.of(context);
    //  final screenHeight = MediaQuery.of(context).size.height;

    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor,
                      theme.colorScheme.secondary,
                    ], 
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Lottie.asset(
                        'assets/animations/waves.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Obx(
                        () => Text(
                          '${controller.notifications.length} Pending',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              const Shadow(
                                blurRadius: 10,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ).animate().fadeIn().scale(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list_rounded),
                onPressed: () => _showFilterDialog(context),
              ),
            ],
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const ShimmerLoader(),
                  childCount: 5,
                ),
              );
            }

            if (controller.notifications.isEmpty) {
              return const EmptyNotification();
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return ErrorNotification(controller: controller);
            }

            return AnimationLimiter(
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final notification = controller.notifications[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 2000),
                      child: SlideAnimation(
                        verticalOffset: 200.0,
                        child: FadeInAnimation(
                          child: NotificationCard(
                            notification: notification,
                            onDismiss: () => controller.removeNotification(
                              notification.productId,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: controller.notifications.length,
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.cleaning_services_rounded),
        onPressed: () {
          confirmRemoveAllNotifications(context, controller);
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Notifications'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add filter options here
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

void confirmRemoveAllNotifications(
  BuildContext context,
  NotificationController controller,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/delete_confirmation.json',
              height: 100,
              repeat: false,
            ),
            const SizedBox(height: 16),
            Text(
              'Delete All Notifications',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to delete all notifications? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.removeAllNotification();
                    Navigator.pop(context);
                    _showDeleteSuccess(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void _showDeleteSuccess(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/delete.json',
              height: 100,
              repeat: false,
            ),
            const SizedBox(height: 16),
            Text(
              'Success!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'All notifications have been deleted.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
