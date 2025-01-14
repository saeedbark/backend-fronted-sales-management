import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/login/login_model.dart';
import 'package:e_commerce/src/auth/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey formKey = GlobalKey<FormState>();

  bool isVisibilty = false;

  void visibilty() {
    isVisibilty = !isVisibilty;
    update();
  }

  Future<LoginModel?> login(BuildContext context) async {
    isLoading.value = true;
    try {
      final response = await LoginService().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      isLoading.value = false;

     // AppRoutes.router.go( AppRoutes.product);

      AppRoutes.router.go(AppRoutes.otp);

      return LoginModel.fromJson(response['data']);
    } on AppException catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;

      return null;
    }
  }
}
