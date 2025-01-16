
import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/src/products/products_serivce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = <ProductModels>[].obs;
  var favoritesList = <ProductModels>[].obs;
  var isLoading = true.obs;
  var searchList = <ProductModels>[].obs;
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
    print('============');
    print(existIndex);
    print('============');
    if (existIndex >= 0) {
      favoritesList.removeAt(existIndex);
      //await storage.remove('isFavoritesList');
    } else {
      favoritesList
          .add(productList.firstWhere((element) => element.id == productId));

     // await storage.write('isFavoritesList', favoritesList);
    }
  }

  bool isFavorites(int productId) {
    return favoritesList.any((element) => element.id == productId);
  }

  // ///////// Search Bar Logic
  // void addSearchToList(String searchName) {
  //   searchName = searchName.toLowerCase();
  //   searchList.value = productList.where((search) {

  //     var searchTitle = search.title.toLowerCase();
  //     var searchPrice= search.price.toString().toLowerCase();

  //     return searchTitle.contains(searchName) ||
  //         searchPrice.toString().contains(searchName);
  //   }).toList();

  //   update();
  // }

  // void clearSearch() {
  //   searchController.clear();
  //   addSearchToList("");
  // }
}
