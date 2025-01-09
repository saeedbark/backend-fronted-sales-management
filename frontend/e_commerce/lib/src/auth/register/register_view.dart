import 'package:e_commerce/constent/my_string.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/register/register_controller.dart';
import 'package:e_commerce/src/widget/auth/auth_button.dart';
import 'package:e_commerce/src/widget/auth/auth_text_field_form.dart';
import 'package:e_commerce/src/widget/auth/container_under.dart';
import 'package:e_commerce/src/widget/check_widget.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? blackColor : Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              text: 'SIGN',
                              color: Colors.deepOrange,
                              underline: TextDecoration.none,
                            ),
                            const SizedBox(width: 5),
                            TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              text: 'UP',
                              color: Get.isDarkMode ? Colors.white : blackColor,
                              underline: TextDecoration.none,
                            )
                          ],
                        ),
                        const SizedBox(height: 50),
                        authTextFromField(
                          controller: controller.nameController,
                          obscureText: false,
                          cursorColor: Colors.black,
                          fillColor: Colors.grey.shade200,
                          prefixIcon: Get.isDarkMode
                              ? Image.asset(
                                  'assets/images/user4.png',
                                  height: 10,
                                  width: 10,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.person,
                                  color: Colors.deepOrange,
                                  size: 30,
                                ),
                          suffixIcon: const Text(""),
                          text: 'User Name',
                          type: TextInputType.name,
                          validator: (Value) {
                            if (Value.toString().length <= 2 ||
                                !RegExp(validationName).hasMatch(Value)) {
                              return 'Enter valid name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        authTextFromField(
                          controller: controller.emailController,
                          obscureText: false,
                          cursorColor: Colors.black,
                          fillColor: Colors.grey.shade200,
                          prefixIcon: Get.isDarkMode
                              ? Image.asset(
                                  'assets/images/email1.png',
                                  height: 10,
                                  width: 10,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.email,
                                  color: Colors.deepOrange,
                                  size: 30,
                                ),
                          suffixIcon: const Text(""),
                          text: 'Email',
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (!RegExp(validationEmail).hasMatch(value)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GetBuilder<RegisterController>(
                          builder: (_) {
                            return authTextFromField(
                              controller: controller.passwordController,
                              obscureText:
                                  controller.isVisibilty ? false : true,
                              cursorColor: Colors.black,
                              fillColor: Colors.grey.shade200,
                              prefixIcon: Get.isDarkMode
                                  ? Image.asset(
                                      'assets/images/passwo.png',
                                      height: 7,
                                      width: 7,
                                      color: Colors.blue,
                                    )
                                  : const Icon(
                                      Icons.password,
                                      color: Colors.deepOrange,
                                      size: 30,
                                    ),
                              suffixIcon: IconButton(
                                onPressed: controller.visibilty,
                                icon: controller.isVisibilty
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      ),
                              ),
                              text: 'Password',
                              type: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.toString().length <= 8) {
                                  return 'Password should be longer or equal to 8 characters';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        const CheckWidget(),
                        const SizedBox(height: 50),
                        GetBuilder<RegisterController>(
                          builder: (_) {
                            return AuthButton(
                              onpress: () {
                                if (controller.ischeckBox == false) {
                                  Get.snackbar(
                                    'Check Box',
                                    'please , Accept terms & conditions',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                } else {
                                  //    if(formKey.currentState!.validate()){
                                  String name =
                                      controller.nameController.text.trim();
                                  String email =
                                      controller.emailController.text.trim();
                                  String password =
                                      controller.passwordController.text;
                                  // controller.signUpUsingFirebase(
                                  //     name: name,
                                  //     email: email,
                                  //     password: password
                                  // );
                                  controller.ischeckBox = true;
                                  //    }
                                }
                              },
                              text: 'SIGN UP',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                text: 'Already have an Account? ',
                textType: 'Log in',
                onPress: () => context.go(AppRoutes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
