import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/login/login_controller.dart';
import 'package:e_commerce/src/auth/register/register_view.dart';
import 'package:e_commerce/src/widget/auth/auth_button.dart';
import 'package:e_commerce/src/widget/auth/auth_text_field_form.dart';
import 'package:e_commerce/src/widget/auth/container_under.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/src/widget/validation.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
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
                              color: Get.isDarkMode ? Colors.white : blackColor,
                              underline: TextDecoration.none,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AuthTextFormField(
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
                          validator: (value) =>
                              ValidationUtils.validateEmail(value.toString()),
                        ),
                        const SizedBox(height: 20),
                        GetBuilder<LoginController>(builder: (_) {
                          return AuthTextFormField(
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
                                    ),
                            ),
                            text: 'Password',
                            type: TextInputType.visiblePassword,
                            validator: (value) =>
                                ValidationUtils.validatePassword(
                                    value.toString()),
                          );
                        }),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () => Get.toNamed(
                              AppRoute.passwordResetRequest,
                            ),
                            child: TextUtils(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              text: 'Forget Password? ',
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              underline: TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                          height: 50,
                        ),
                        AuthButton(
                          onpress: () => controller.login(context),
                          text: 'LOG IN',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                ContainerUnder(
                  text: "Don't have an Account?",
                  textType: 'Sign up',
                  onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
