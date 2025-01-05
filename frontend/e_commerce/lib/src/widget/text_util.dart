// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final String text;
  final Color color;
  final TextDecoration underline;
  const TextUtils(
      {required this.fontSize,
      required this.fontWeight,
      required this.text,
      required this.color,
      required this.underline});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: underline,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}