import 'package:e_commerce/constent/my_string.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/login/login_controller.dart';
import 'package:e_commerce/src/widget/auth/auth_button.dart';
import 'package:e_commerce/src/widget/auth/auth_text_field_form.dart';
import 'package:e_commerce/src/widget/auth/container_under.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? blackColor : Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 40),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              text: 'LOG',
                              color: Colors.deepOrange,
                              underline: TextDecoration.none,
                            ),
                            const SizedBox(width: 5),
                            TextUtils(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                text: 'IN',
                                color:
                                    Get.isDarkMode ? Colors.white : blackColor,
                                underline: TextDecoration.none)
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
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
                          validator: (Value) {
                            if (!RegExp(validationEmail).hasMatch(Value)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GetBuilder<LoginController>(builder: (_) {
                          return authTextFromField(
                            controller: controller.passwordController,
                            obscureText: controller.isVisibilty ? false : true,
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
                                onPressed: () {
                                  controller.visibilty();
                                },
                                icon: controller.isVisibilty
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )),
                            text: 'Password',
                            type: TextInputType.visiblePassword,
                            validator: (Value) {
                              if (Value.toString().length <= 8) {
                                return 'Password should be longer or equal to 8 characters';
                              }
                              return null;
                            },
                          );
                        }),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              //  Get.toNamed(Routes.forgetScreen);
                            },
                            child: TextUtils(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                text: 'Forget Password? ',
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                underline: TextDecoration.none),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GetBuilder<LoginController>(builder: (_) {
                          return AuthButton(
                            onpress: () => controller.login(context),
                            text: 'LOG IN',
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextUtils(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            text: 'OR',
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            underline: TextDecoration.none),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GetBuilder<LoginController>(builder: (_) {
                              return InkWell(
                                onTap: () {
                                  //controller.googleSignUpApp();
                                },
                                child: Image.asset(
                                  'assets/images/google1.png',
                                  height: 44,
                                  width: 44,
                                ),
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ContainerUnder(
                  text: "Don't have an Account?",
                  textType: 'Sign up',
                  onPress: () => context.go(AppRoutes.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
