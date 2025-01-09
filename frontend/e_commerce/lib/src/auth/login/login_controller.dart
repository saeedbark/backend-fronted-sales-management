import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/shared_pref/shared_preferences.dart';
import 'package:e_commerce/src/auth/login/login_model.dart';
import 'package:e_commerce/src/auth/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
      final response = await LoginService().login(emailController.text.trim(), passwordController.text.trim(),);
      await SharedPreferencesHelper.setString('token', response['data']['token']);

      isLoading.value = false;
        context.go(AppRoutes.home);
      

      return LoginModel.fromJson(response['data']);
    } on AppException catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;

      return null;
    }
  }
}
