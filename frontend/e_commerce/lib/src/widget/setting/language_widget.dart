import 'package:e_commerce/constent/my_string.dart';
import 'package:e_commerce/src/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../text_util.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return GetBuilder<SettingController>(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink,
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextUtils(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    text: 'Language'.tr,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    underline: TextDecoration.none,
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              // height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    width: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  iconSize: 25,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: ara,
                      child: Text(
                        arabic,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ene,
                      child: Text(
                        english,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: frf,
                      child: Text(
                        french,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  value: controller.langLocal,
                  onChanged: (value) {
                    controller.changeLanguage(value!);
                    Get.updateLocale(Locale(value));
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
