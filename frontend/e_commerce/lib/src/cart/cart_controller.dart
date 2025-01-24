import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var productsMap = {}.obs;

  void addProductToCart(ProductModels productModels) {
    if (productsMap.containsKey(productModels)) {
      productsMap[productModels] += 1;
      // var total =   productsMap.entries
      //     .map((e) => e.key.price * e.value)
      //     .toList()
      //     .reduce((value, element) => value + element)
      //     .toStringAsFixed(2);
      // print(total);
      //  print(productsMap.value.toString());
    } else {
      productsMap[productModels] = 1;
      //print(productsMap.value.toString());
      // var tota = productsMap.entries
      //     .map((e) => e.key.price * e.value)
      //     .toList()
      //     .reduce((value, element) => value + element)
      //     .toStringAsFixed(2);
      // print(tota);
    }
  }

  void removeProductFromCart(ProductModels productModels) {
    if (productsMap.containsKey(productModels) &&
        productsMap[productModels] == 1) {
      productsMap.removeWhere((key, value) => key == productModels);
    } else {
      productsMap[productModels] -= 1;
    }
  }

  void removeOneProduct(ProductModels productModels) {
    productsMap.removeWhere((key, value) => key == productModels);
  }

  void clearAllProducts() {
    Get.defaultDialog(
      title: 'Clean Products',
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      middleText: 'Are you sure you need to clear all products ',
      middleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      backgroundColor: Colors.grey,
      radius: 10,
      textCancel: 'NO',
      cancelTextColor: Get.isDarkMode ? Colors.white : blackColor,
      textConfirm: 'YES',
      confirmTextColor: Get.isDarkMode ? Colors.white : blackColor,
      onCancel: () {
       // Get.toNamed(Routes.cartScreen);
      },
      onConfirm: () {
        productsMap.clear();
        Get.back();
      },
      buttonColor: Get.isDarkMode ? pinkColor : mainColor,
    );
  }

  get productSubTotal =>
      productsMap.entries.map((e) => e.key.price * e.value).toList();

  get total => productsMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element)
     ;

  int quantity() {
    if(productsMap.isEmpty){
      return 0;
    }
    else {
      return productsMap.entries
          .map((e) => e.value)
          .toList()
          .reduce((value, element) => value + element);
    }
  }
}
