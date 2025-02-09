import 'package:e_commerce/src/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorNotification extends StatelessWidget {
  final NotificationController controller;

  const ErrorNotification({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
}