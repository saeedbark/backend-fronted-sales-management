import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/forget_password/forget_password_service.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  var email = "".obs;
  var otp = "".obs;
  var newPassword = "".obs;
  var isLoading = false.obs;

  final _service = PasswordResetService();

  Future<void> requestOTP() async {
    isLoading.value = true;
    final response = await _service.requestOTP(email.value);
    isLoading.value = false;

    if (response['message'] != null) {
      Get.snackbar("Success", "OTP sent to your email");
      Get.toNamed(AppRoute.verifyOtp);
    } else {
      Get.snackbar("Error", "Failed to send OTP");
    }
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    var response = await _service.verifyOTP(email.value, otp.value);
    isLoading.value = false;

    if (response['message'] != null) {
      Get.snackbar("Success", "OTP verified");
      Get.toNamed(AppRoute.resetPassword);
    } else {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  Future<void> resetPassword() async {
    isLoading.value = true;
    var response =
        await _service.resetPassword(email.value, otp.value, newPassword.value);
    isLoading.value = false;

    if (response['message'] != null) {
      Get.snackbar("Success", "Password reset successfully");
      Get.offAllNamed(AppRoute.login);
    } else {
      Get.snackbar("Error", "Failed to reset password");
    }
  }
}
