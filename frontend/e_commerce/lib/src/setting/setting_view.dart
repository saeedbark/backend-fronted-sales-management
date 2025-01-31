import 'package:e_commerce/src/widget/setting/darkMode_widget.dart';
import 'package:e_commerce/src/widget/setting/language_widget.dart';
import 'package:e_commerce/src/widget/setting/log_out_widget.dart';
import 'package:e_commerce/src/widget/setting/profile_widget.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const ProfileImage(),
          const SizedBox(height: 10),
          Divider(
            color: Get.isDarkMode ? Colors.white : Colors.grey,
            thickness: 2,
          ),
          const SizedBox(height: 20),
          TextUtils(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            text: 'GENERAL'.tr,
            color: Get.isDarkMode ? pinkColor : mainColor,
            underline: TextDecoration.none,
          ),
          const SizedBox(height: 20),
           DarkModeWidget(),
          const SizedBox(height: 20),
          LanguageWidget(),
          const SizedBox(height: 20),
          LogOutWidget(),
        ],
      ),
    );
  }
}
