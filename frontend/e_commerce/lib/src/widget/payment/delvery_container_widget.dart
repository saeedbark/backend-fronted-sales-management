import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/payment/payment_controller.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryContainerWidget extends StatefulWidget {
  const DeliveryContainerWidget({super.key});

  @override
  State<DeliveryContainerWidget> createState() =>
      _DeliveryContainerWidgetState();
}

class _DeliveryContainerWidgetState extends State<DeliveryContainerWidget> {
  final phoneController = TextEditingController();
  int radioContainerIndex = 1;
  bool changeColors = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    return Column(
      children: [
        buildRadioContainer(
          color: changeColors ? Colors.white : Colors.grey.shade300,
          value: 1,
          icon: Container(),
          onChanged: (int value) {
            setState(() {
              radioContainerIndex = value;
              changeColors = !changeColors;
            });
          },
          title: 'Saeed Shop',
          name: 'Saeed Store',
          phone: '42-721-553',
          adress: 'Mauritania, Nouakchott ',
        ),
        SizedBox(height: 10),
        Obx(() {
          return buildRadioContainer(
            color: changeColors ? Colors.grey.shade300 : Colors.white,
            value: 2,
            icon: InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: 'Enter Your Phone Number',
                  titleStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.white,
                  radius: 10,
                  textCancel: 'Cancel ',
                  cancelTextColor: Colors.black,
                  textConfirm: 'Save ',
                  confirmTextColor: Colors.black,
                  onCancel: () {
                    Get.toNamed(AppRoute.payment);
                  },
                  onConfirm: () {
                    Get.back();
                    controller.phoneNumber.value = phoneController.text;
                  },
                  buttonColor: Get.isDarkMode ? pinkColor : mainColor,
                  content: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: phoneController,
                      maxLength: 8,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        phoneController.text = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Get.isDarkMode
                            ? pinkColor.withOpacity(0.2)
                            : mainColor.withOpacity(0.2),
                        focusColor: Colors.red,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Get.isDarkMode ? pinkColor : mainColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            phoneController.clear();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter Your Phone Number",
                        hintStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.contact_phone,
                size: 20,
                color: Get.isDarkMode ? pinkColor : mainColor,
              ),
            ),
            onChanged: (int value) {
              setState(() {
                radioContainerIndex = value;
                changeColors = !changeColors;
              });
              controller.updatePosition();
            },
            title: 'Delivery',
            name: 'Salem Saeed',
            //authcontroller.displayUserName.value,
            phone: controller.phoneNumber.value,
            adress: controller.address.value,
          );
        })
      ],
    );
  }

  Widget buildRadioContainer({
    required Color color,
    required int value,
    required Function onChanged,
    required String name,
    required String title,
    required String phone,
    required String adress,
    required Widget icon,
  }) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            value: value,
            groupValue: radioContainerIndex,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
            onChanged: (int? value) {
              onChanged(value);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  text: title,
                  color: Colors.black,
                  underline: TextDecoration.none,
                ),
                const SizedBox(height: 5),
                TextUtils(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  text: name,
                  color: Colors.black,
                  underline: TextDecoration.none,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '🇲🇷 +222 ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextUtils(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      text: phone,
                      color: Colors.black,
                      underline: TextDecoration.none,
                    ),
                    const SizedBox(width: 120),
                    SizedBox(child: icon)
                  ],
                ),
                const SizedBox(height: 5),
                TextUtils(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  text: adress,
                  color: Colors.black,
                  underline: TextDecoration.none,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
