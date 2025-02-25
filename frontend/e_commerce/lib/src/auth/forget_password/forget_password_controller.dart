import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/forget_password/forget_password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final formKeyOtp = GlobalKey<FormState>();
  final formKeyRest = GlobalKey<FormState>();

  final _service = PasswordResetService();

  Future<void> requestOTP() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      final response = await _service.requestOTP(emailController.text.trim());
      isLoading.value = false;

      if (response['message'] != null) {
        Get.snackbar("Success", "OTP sent to your email",
            backgroundColor: Colors.green.shade300);
        Get.toNamed(AppRoute.verifyOtp);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red.shade300);
    }
  }

  Future<void> verifyOTP() async {
    if (!formKeyOtp.currentState!.validate()) return;
    isLoading.value = true;

    try {
      final response = await _service.verifyOTP(
        emailController.text.trim(),
        otpController.text.trim(),
      );
      isLoading.value = false;

      if (response['message'] != null) {
        Get.snackbar("Success", "OTP verified");
        Get.toNamed(AppRoute.resetPassword);
      }

      if (response['error'] != null) {
        Get.snackbar("Error", response['error']);
      }
    } on AppException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red.shade300);
    }
  }

  Future<void> resetPassword() async {
    if (!formKeyRest.currentState!.validate()) return;
    isLoading.value = true;

    try {
      var response = await _service.resetPassword(
        emailController.text.trim(),
        otpController.text.trim(),
        newPasswordController.text.trim(),
      );
      isLoading.value = false;

      if (response['message'] != null) {
        Get.snackbar("Success", "Password reset successfully");
        Get.offAllNamed(AppRoute.login);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red.shade300);
    }
  }
}
