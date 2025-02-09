import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/auth/otp/otp_service.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/network/app_exceptions.dart';

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
      } else {
        response['error'] ?? 'Failed to send OTP';
      }
    } catch (e, stacktrace) {
      if (e is AppException) {}
      print('Exception: $e, Stacktrace: $stacktrace');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) return;

    if (sentOtp.value == otpController.text.trim()) {
      SharedPreferencesHelper.setString('code', sentOtp.value);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductsView()),
      );
    }
  }
}
