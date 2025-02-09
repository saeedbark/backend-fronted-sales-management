import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
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
          duration: 2000.ms,
          delay:300.ms,
          color: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
        )
        .fade(
          duration: 1000.ms,
          curve: Curves.easeInOut,
        );
  }
}