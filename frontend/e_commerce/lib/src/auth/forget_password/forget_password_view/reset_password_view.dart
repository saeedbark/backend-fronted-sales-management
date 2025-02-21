import 'package:e_commerce/src/auth/forget_password/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordResetController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => controller.newPassword.value = value,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: "Enter new password"),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.resetPassword,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
