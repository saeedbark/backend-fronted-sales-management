import 'dart:convert';
import 'package:e_commerce/src/cart/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/src/products/products_controller.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var productsMap = <ProductModels, int>{}.obs;
  // ... other existing variables

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  List<String>? savedCartItems;

  Future<void> loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCartItems = prefs.getStringList('cartItems');
    if (savedCartItems == null) return;

    ProductController productController = Get.find<ProductController>();

    if (productController.productList.isEmpty) {
      await productController.getProducts();
    }

    for (String itemJson in savedCartItems) {
      try {
        CartItem cartItem = CartItem.fromJson(jsonDecode(itemJson));
        final product = productController.productList.firstWhereOrNull(
          (p) => p.id == cartItem.productId,
        );
        if (product != null) {
          productsMap[product] = cartItem.quantity;
        }
      } catch (e) {
        print('Error loading cart item: $e');
      }
    }
  }

  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = [];

    productsMap.forEach((product, quantity) {
      CartItem cartItem = CartItem(
        productId: product.id,
        quantity: quantity,
        dateAdded: DateTime.now(), // Update this with actual date if tracked
        price: product.price,
      );
      cartItemsJson.add(jsonEncode(cartItem.toJson()));
    });

    await prefs.setStringList('cartItems', cartItemsJson);
  }

  void addProductToCart(ProductModels productModels) {
    if (productsMap.containsKey(productModels)) {
      productsMap[productModels] = productsMap[productModels]! + 1;
    } else {
      productsMap[productModels] = 1;
    }
    saveCart();
  }

  void removeProductFromCart(ProductModels productModels) {
    if (productsMap.containsKey(productModels)) {
      if (productsMap[productModels] == 1) {
        productsMap.remove(productModels);
      } else {
        productsMap[productModels] = productsMap[productModels]! - 1;
      }
      saveCart();
    }
  }

  void clearAllProducts() {
    productsMap.clear();
    saveCart();
  }

  void removeOneProduct(ProductModels productModels) {
    if (productsMap.containsKey(productModels)) {
      productsMap.remove(productModels); // Remove the product entirely
      saveCart(); // Save the updated cart to SharedPreferences
    }
  }

  List<double> get productSubTotal {
    return productsMap.entries.map((entry) {
      return entry.key.price * entry.value; // Price × Quantity
    }).toList();
  }

  double get total {
    return productsMap.entries.fold(0, (sum, entry) {
      return sum + (entry.key.price * entry.value); // Sum of all subtotals
    });
  }

  int quantity() {
    if (productsMap.isEmpty) {
      return 0;
    } else {
      return productsMap.entries.length;
    }
  }

  // ... existing methods
}
