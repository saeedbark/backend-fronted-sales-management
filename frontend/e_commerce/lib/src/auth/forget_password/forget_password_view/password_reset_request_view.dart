import 'package:e_commerce/src/auth/forget_password/forget_password_controller.dart';
import 'package:e_commerce/src/widget/auth/auth_text_field_form.dart';
import 'package:e_commerce/src/widget/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetRequestView extends StatelessWidget {
  const PasswordResetRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordResetController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Password Reset"),
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
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your email to receive a reset link",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    AuthTextFormField(
                      controller: controller.emailController,
                      obscureText: false,
                      cursorColor: Colors.black,
                      fillColor: Colors.grey.shade200,
                      prefixIcon: Get.isDarkMode
                          ? Image.asset(
                              'assets/images/email1.png',
                              height: 10,
                              width: 10,
                              color: Colors.blue,
                            )
                          : const Icon(
                              Icons.email,
                              color: Colors.deepOrange,
                              size: 30,
                            ),
                      suffixIcon: const Text(""),
                      text: 'Email',
                      type: TextInputType.emailAddress,
                      validator: (value) =>
                          ValidationUtils.validateEmail(value.toString()),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: controller.requestOTP,
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
                                  "Send OTP",
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
