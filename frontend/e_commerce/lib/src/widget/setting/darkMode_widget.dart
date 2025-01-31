import 'package:e_commerce/src/setting/setting_controller.dart';
import 'package:e_commerce/src/setting/theme_controller.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeWidget extends StatelessWidget {
  const DarkModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconWidget(),
        Obx(() {
          return Switch(
              activeTrackColor: Get.isDarkMode ? pinkColor : mainColor,
              activeColor: Get.isDarkMode ? pinkColor : mainColor,
              value: controller.switchValue.value,
              onChanged: (value) {
                ThemeController().changeTheme();
                controller.switchValue.value = value;
              });
        }),
      ],
    );
  }

  Widget buildIconWidget() {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: darkSettings,
            ),
            child: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          TextUtils(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            text: 'Dark Mode'.tr,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            underline: TextDecoration.none,
          ),
        ],
      ),
    );
  }
}
