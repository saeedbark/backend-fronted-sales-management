import 'package:e_commerce/src/widget/home/card_item.dart';
import 'package:e_commerce/src/widget/home/search_form_text.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final heigh = MediaQuery.of(context).size.height * 0.2;
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: heigh,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? blackColor : mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      text: 'Find your',
                      color: Colors.white,
                      underline: TextDecoration.none,
                    ),
                    SizedBox(height: 5),
                    TextUtils(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      text: 'Products',
                      color: Colors.white,
                      underline: TextDecoration.none,
                    ),
                    SizedBox(height: 20),
                    SearchFormText(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextUtils(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  text: 'Products',
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  underline: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CardItem(),
          ],
        ),
      ),
    );
  }
}
