import 'package:e_commerce/src/notification/notification_controller.dart';
import 'package:e_commerce/src/notification/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    final theme = Theme.of(context);

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
                      child: Obx(() => Text(
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
                          ).animate().fadeIn().scale()),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
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
                  (context, index) => _buildShimmerLoader(),
                  childCount: 5,
                ),
              );
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/error.json',
                        height: 150,
                      ),
                      Text(
                        controller.errorMessage.value,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        onPressed: controller.loadNotifications,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.notifications.isEmpty) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/empty.json',
                      height: 200,
                    ),
                    Text(
                      'All caught up! 🎉',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              );
            }

            return AnimationLimiter(
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final notification = controller.notifications[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: _NotificationCard(
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
        onPressed: () => {},
      ).animate().scale(delay: 300.ms),
    );
  }

  Widget _buildShimmerLoader() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: 1000.ms,
          delay: 300.ms,
          color: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
        )
        .fade(
          duration: 1000.ms,
          curve: Curves.easeInOut,
        );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Notifications'),
        content: Column(
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

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDismiss;
  const _NotificationCard({
    required this.notification,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysPassed = notification.daysSinceAdded;

    return Dismissible(
      key: Key(notification.productId.toString()),
      direction: DismissDirection.endToStart,
      background: _buildDismissibleBackground(),
      onDismissed: (direction) => onDismiss(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: _getUrgencyColor(daysPassed),
                width: 4,
              ),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: _buildProductIcon(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name', // Add product name to your model
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(notification.dateAdded),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildUrgencyBadge(daysPassed),
                Text(
                  '\$${notification.price.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getUrgencyColor(notification.daysSinceAdded).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.shopping_cart,
        color: _getUrgencyColor(notification.daysSinceAdded),
        size: 20,
      ),
    );
  }

  Widget _buildUrgencyBadge(int days) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getUrgencyColor(days).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timelapse,
            size: 14,
            color: _getUrgencyColor(days),
          ),
          const SizedBox(width: 4),
          Text(
            '${days}d',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _getUrgencyColor(days),
            ),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(int days) {
    if (days > 7) return Colors.redAccent;
    if (days > 3) return Colors.orange;
    return Colors.blueAccent;
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy • HH:mm').format(date);
  }

  Widget _buildDismissibleBackground() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: Icon(
        Icons.delete_forever_rounded,
        color: Colors.red.shade600,
        size: 32,
      ),
    );
  }
}
