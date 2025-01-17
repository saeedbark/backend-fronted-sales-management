
import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/src/products/products_serivce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final  productList = <ProductModels>[].obs;
  final favoritesList = <ProductModels>[].obs;
  final isLoading = true.obs;
  final searchList = <ProductModels>[].obs;

  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  
    getProducts();
  }

  Future<List<ProductModels>?> getProducts() async {
    isLoading.value = true;
    try {
      final response = await ProductsSerivce().getProducts();

      isLoading.value = false;

     // Using assignAll to update the RxList
      productList.assignAll(
        (response['data']['products'] as List)
            .map((element) => ProductModels.fromJson(element))
            .toList(),
      );

      

      return productList;
    } on AppException catch (e) {
    //  Get.snackbar('Error', e.toString());
    print('errrrrorr$e');
      isLoading.value = false;

      return null;
    }
  }

  void manageFavorites(int productId) async {
    var existIndex =
        favoritesList.indexWhere((element) => element.id == productId);

    if (existIndex >= 0) {
      favoritesList.removeAt(existIndex);
    } else {
      favoritesList
          .add(productList.firstWhere((element) => element.id == productId));

    }
  }

  bool isFavorites(int productId) {
    return favoritesList.any((element) => element.id == productId);
  }


}
