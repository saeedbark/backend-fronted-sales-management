import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/auth/login/login_model.dart';
import 'package:e_commerce/src/auth/login/login_service.dart';
import 'package:e_commerce/src/auth/otp/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisibilty = false;

  void visibilty() {
    isVisibilty = !isVisibilty;
    update();
  }

  Future<LoginModel?> login(BuildContext context) async {
    if (!(formKey.currentState as FormState).validate()) return null;
    isLoading.value = true;
    try {
      final response = await LoginService().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      isLoading.value = false;

      Get.to(() => const OtpView());

      return LoginModel.fromJson(response['data']);
    } on AppException catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;

      return null;
    }
  }
}
