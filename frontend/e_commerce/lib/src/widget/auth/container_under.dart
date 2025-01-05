
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerUnder extends StatelessWidget {
  final String text;
  final String textType;
  final Function() onPress;

  const ContainerUnder(
      {super.key,
      required this.text,
      required this.textType,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? mainColor : Colors.deepOrange,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              text: text,
              color: Colors.white,
              underline: TextDecoration.none),
          TextButton(
            onPressed: onPress,
            child: TextUtils(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                text: textType,
                color: Colors.white,
                underline: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}