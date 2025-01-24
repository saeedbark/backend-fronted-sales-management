
import 'package:e_commerce/src/cart/cart_controller.dart';
import 'package:e_commerce/src/widget/cart/cart_product_card.dart';
import 'package:e_commerce/src/widget/cart/cart_total.dart';
import 'package:e_commerce/src/widget/cart/cart_widget.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
 const CartView({super.key});
  @override
  Widget build(BuildContext context) {
  final controller = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Cart Item'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Get.isDarkMode ? blackColor : mainColor,
          actions: [
            IconButton(
                onPressed: () {
                  controller.clearAllProducts();
                },
                icon: const Icon(Icons.backspace)),
          ],
        ),
        body: Obx(
          () {
            if (controller.productsMap.isEmpty) {
              return const EmptyCard();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 650,
                      child: ListView.separated(
                        itemBuilder: (context, index) => CartProductCard(
                          productModels:
                              controller.productsMap.keys.toList()[index],
                          index: index,
                          quantity:
                              controller.productsMap.values.toList()[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: controller.productsMap.length,
                      ),
                    ),
                   const Padding(
                      padding:  EdgeInsets.all(20.0),
                      child: CartTotal(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
