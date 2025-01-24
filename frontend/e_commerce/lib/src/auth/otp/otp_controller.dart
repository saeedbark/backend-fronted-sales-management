// controllers/otp_controller.dart
import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/auth/otp/otp_service.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/network/app_exceptions.dart';

class OtpController extends GetxController {
  // Controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  // Form Keys
  final phoneFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  // State Variables
  var isLoading = false.obs;
  var isOtpSent = false.obs;
  var sentOtp = ''.obs; // Stores the OTP returned from the server

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // Send OTP Function
  Future<void> sendOtp() async {
    if (!phoneFormKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final response = await OtpService().sendOtp(phoneController.text.trim());

      if (response['code'] != null) {
        sentOtp.value = response['code'].toString();
        isOtpSent.value = true;
      } else {
        response['error'] ?? 'Failed to send OTP';
      }
    } catch (e, stacktrace) {
      if (e is AppException) {}
      // Log the exception details for debugging
      print('Exception: $e, Stacktrace: $stacktrace');
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP Function
  Future<void> verifyOtp(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) return;

    // Compare the sent OTP with the user-entered OTP
    if (sentOtp.value == otpController.text.trim()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductsView()),
      );
              SharedPreferencesHelper.setString('code', sentOtp.value);

    }
  }
}
