import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/cart/cart_controller.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Obx(
      () => Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextUtils(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                text: 'Total',
                color: Colors.grey,
                underline: TextDecoration.none,
              ),
              Text(
                controller.total.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Get.isDarkMode ? Colors.white : blackColor,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Get.isDarkMode ? pinkColor : mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  Get.toNamed(AppRoute.payment);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Check Out',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.shopping_cart)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
