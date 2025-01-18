import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/src/products/products_serivce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  final productList = <ProductModels>[].obs;
  final favoritesList = <ProductModels>[].obs;
  final isLoading = true.obs;
  final searchList = <ProductModels>[].obs;

  TextEditingController searchController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    getProducts();
    loadFavorites(); 
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedFavoriteIds = prefs.getStringList('isFavoritesList') ?? [];
    
    // Convert saved IDs back to ProductModels
    favoritesList.clear();
    for (String idStr in savedFavoriteIds) {
      int id = int.parse(idStr);
      final product = productList.firstWhereOrNull((p) => p.id == id);
      if (product != null) {
        favoritesList.add(product);
      }
    }
  }

  Future<List<ProductModels>?> getProducts() async {
    isLoading.value = true;
    try {
      final response = await ProductsSerivce().getProducts();
      isLoading.value = false;

      productList.assignAll(
        (response['data']['products'] as List)
            .map((element) => ProductModels.fromJson(element))
            .toList(),
      );
      
      // Reload favorites after products are loaded
      await loadFavorites();
      return productList;
    } on AppException catch (e) {
      print('Error: $e');
      isLoading.value = false;
      return null;
    }
  }

  Future<void> manageFavorites(int productId) async {
    var existIndex = favoritesList.indexWhere((element) => element.id == productId);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (existIndex >= 0) {
      favoritesList.removeAt(existIndex);
    } else {
      var product = productList.firstWhereOrNull((element) => element.id == productId);
      if (product != null) {
        favoritesList.add(product);
      }
    }

    // Save the IDs of favorite products
    await prefs.setStringList(
      'isFavoritesList', 
      favoritesList.map((product) => product.id.toString()).toList()
    );
  }

  bool isFavorites(int productId) {
    return favoritesList.any((element) => element.id == productId);
  }
}