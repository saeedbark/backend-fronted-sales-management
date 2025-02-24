import 'package:e_commerce/src/auth/forget_password/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetRequestView extends StatelessWidget {
  const PasswordResetRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordResetController());
    return Scaffold(
      appBar: AppBar(title: const Text("Request Password Reset")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: const InputDecoration(labelText: "Enter your email"),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.requestOTP,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Send OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
