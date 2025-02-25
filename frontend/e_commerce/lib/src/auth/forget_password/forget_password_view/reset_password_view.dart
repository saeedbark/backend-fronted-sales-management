import 'package:e_commerce/src/auth/forget_password/forget_password_controller.dart';
import 'package:e_commerce/src/widget/auth/auth_text_field_form.dart';
import 'package:e_commerce/src/widget/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordResetController controller = Get.find();
    final RxBool obscureText = true.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: controller.formKeyRest,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Reset Your Password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your new password below",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => AuthTextFormField(
                        controller: controller.newPasswordController,
                        obscureText: obscureText.value,
                        text: "Enter new password",
                        type: TextInputType.visiblePassword,
                        cursorColor: Colors.deepOrange,
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.deepOrange),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            obscureText.value = !obscureText.value;
                          },
                        ),
                        validator: (value) =>
                            ValidationUtils.validatePassword(value ?? ""),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (controller.formKeyRest.currentState!
                                      .validate()) {
                                    controller.resetPassword();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
