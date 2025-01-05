import 'package:flutter/material.dart';

class authTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String text;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Function validator;
  final Color cursorColor;
  final Color fillColor;
  final TextInputType type;

  const authTextFromField(
      {required this.controller,
      required this.obscureText,
      required this.text,
      required this.prefixIcon,
      required this.validator,
      required this.cursorColor,
      required this.type,
      required this.suffixIcon,
      required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: cursorColor,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) => (value),
    );
  }
}