import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/otp/enter_otp/enter_otp_view.dart';
import 'package:e_commerce/src/auth/otp/otp_controller.dart';
import 'package:e_commerce/src/widget/auth/auth_button.dart';
import 'package:e_commerce/src/widget/auth/auth_text_field_form.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? blackColor : Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextUtils(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    text: 'Enter Phone',
                    color: Colors.deepOrange,
                    underline: TextDecoration.none,
                  ),
                  const SizedBox(height: 30),
                  authTextFromField(
                    controller: controller.otpController,
                    obscureText: false,
                    cursorColor: Colors.black,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Get.isDarkMode
                        ? Image.asset(
                            'assets/images/user.png',
                            height: 10,
                            width: 10,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.phone,
                            color: Colors.deepOrange,
                            size: 30,
                          ),
                    suffixIcon: const Text(""),
                    text: 'OTP',
                    type: TextInputType.phone,
                    validator: (value) {
                      if (!value) {
                        return 'Enter valid phone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<OtpController>(builder: (_) {
                    return AuthButton(
                      onpress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EnterOtp(),
                        ),
                      ),
                      text: 'Send OTP',
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
