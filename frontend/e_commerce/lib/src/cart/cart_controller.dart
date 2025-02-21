import 'dart:convert';
import 'package:e_commerce/src/cart/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/src/products/products_controller.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var productsMap = <ProductModels, Map<String, dynamic>>{}
      .obs; // تخزين `quantity` و `dateAdded`

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCartItems = prefs.getStringList('cartItems');
    if (savedCartItems == null) return;

    ProductController productController = Get.find<ProductController>();

    if (productController.productList.isEmpty) {
      await productController.getProducts();
    }

    productsMap.clear(); // تفريغ القائمة قبل إعادة تحميل البيانات

    for (String itemJson in savedCartItems) {
      try {
        CartItem cartItem = CartItem.fromJson(jsonDecode(itemJson));
        final product = productController.productList.firstWhereOrNull(
          (p) => p.id == cartItem.productId,
        );
        if (product != null) {
          productsMap[product] = {
            'quantity': cartItem.quantity,
            'dateAdded': cartItem.dateAdded,
          };
        }
      } catch (e) {
        print('Error loading cart item: $e');
      }
    }
  }

  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = productsMap.entries.map((entry) {
      return jsonEncode({
        'productId': entry.key.id,
        'quantity': entry.value['quantity'],
        'dateAdded': (entry.value['dateAdded'] as DateTime).toIso8601String(),
        'price': entry.key.price,
      });
    }).toList();
    await prefs.setStringList('cartItems', cartItemsJson);
  }

  void addProductToCart(ProductModels product) {
    if (productsMap.containsKey(product)) {
      productsMap[product]!['quantity'] += 1;
    } else {
      productsMap[product] = {
        'quantity': 1,
        'dateAdded': DateTime.now(),
      };
    }
    saveCart();
  }

  void removeProductFromCart(ProductModels product) {
    if (productsMap.containsKey(product)) {
      if (productsMap[product]!['quantity'] == 1) {
        productsMap.remove(product);
      } else {
        productsMap[product]!['quantity'] -= 1;
      }
      saveCart();
    }
  }

  void clearAllProducts() {
    productsMap.clear();
    saveCart();
  }

  void removeOneProduct(ProductModels product) {
    productsMap.remove(product);
    saveCart();
  }

  List<double> get productSubTotal {
    return productsMap.entries.map((entry) {
      return entry.key.price * entry.value['quantity'];
    }).toList();
  }

  double get total {
    return productsMap.entries.fold(0, (sum, entry) {
      return sum + (entry.key.price * entry.value['quantity']);
    });
  }

  int quantity() {
    return productsMap.isEmpty ? 0 : productsMap.length;
  }
}
