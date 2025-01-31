import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({super.key});

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  int radioPaymentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          buildRadioPayment(
            image: 'assets/images/paypal2.png',
            scale: 0.7,
            name: 'Paypal',
            value: 1,
            onchange: (int? value) {
              setState(() {
                radioPaymentIndex = value!;
              });
            },
          ),
          SizedBox(height: 15),
          buildRadioPayment(
            image: 'assets/images/google1.png',
            scale: 0.5,
            name: 'Google Pay',
            value: 2,
            onchange: (int? value) {
              setState(() {
                radioPaymentIndex = value!;
              });
            },
          ),
          SizedBox(height: 15),
          buildRadioPayment(
            image: 'assets/images/credit11.png',
            scale: 0.7,
            name: 'Visa',
            value: 3,
            onchange: (int? value) {
              setState(() {
                radioPaymentIndex = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildRadioPayment({
    required String image,
    required double scale,
    required String name,
    required Function onchange,
    required int value,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Get.isDarkMode
          ? Colors.white.withOpacity(0.8)
          : Colors.grey.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image,
                scale: scale,
              ),
              const SizedBox(width: 15),
              TextUtils(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                text: name,
                color: Colors.black,
                underline: TextDecoration.none,
              ),
            ],
          ),
          Radio(
            value: value,
            groupValue: radioPaymentIndex,
            fillColor: MaterialStateColor.resolveWith((states) => mainColor),
            onChanged: (int? value) {
              onchange(value);
            },
          ),
        ],
      ),
    );
  }
}
