import 'package:e_commerce/src/widget/category/category_widget.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: TextUtils(
                  fontSize: 30,
                  text: 'Category',
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  underline: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
