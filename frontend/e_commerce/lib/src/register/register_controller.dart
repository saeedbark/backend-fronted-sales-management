import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/register/register_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterController extends GetxController {
  final RxBool isLoading = false.obs;

    final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // Add phone field


  Future<void> register(String name, String email, String password, String phone) async {
    isLoading.value = true;
    try {
    await RegisterService().register(name, email, password, phone);
      Get.offAllNamed('/login');
    } on AppException catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}