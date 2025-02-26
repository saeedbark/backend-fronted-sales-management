import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/auth/otp/otp_service.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OtpController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  final phoneFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isOtpSent = false.obs;
  var sentOtp = ''.obs;

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    if (!phoneFormKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final response = await OtpService().sendOtp(phoneController.text.trim());

      if (response['code'] != null) {
        sentOtp.value = response['code'].toString();
        isOtpSent.value = true;
        Get.snackbar("succes", 'Send Otp Succes',
            backgroundColor: Colors.green.shade300);
      }
    } catch (e) {
      print('Exception: $e, Stacktrace: ');
      Get.snackbar("Error", 'Send otp fail',
          backgroundColor: Colors.red.shade300);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      if (sentOtp.value == otpController.text.trim()) {
        SharedPreferencesHelper.setString('code', sentOtp.value);
        Get.snackbar("succes", 'Send Otp Succes',
            backgroundColor: Colors.green.shade300);
        Get.toNamed(AppRoute.product);
      } else {
        Get.snackbar("Error", 'Otp not Correct',
            backgroundColor: Colors.red.shade200);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      print('Exception: $e, Stacktrace: ');
      Get.snackbar("Error", 'Verify otp fail',
          backgroundColor: Colors.red.shade300);
    }
  }
}
