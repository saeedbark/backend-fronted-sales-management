import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/register/register_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool ischeckBox = false;

  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await RegisterService().register(name, email, password, phone);
      Get.offAllNamed(AppRoute.login);
    } on AppException catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool isVisibilty = false;

  void visibilty() {
    isVisibilty = !isVisibilty;
    update();
  }

  void checkBox() {
    ischeckBox = !ischeckBox;
    update();
  }
}
