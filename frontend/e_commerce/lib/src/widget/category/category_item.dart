import 'package:badges/badges.dart' as badge;
import 'package:badges/badges.dart';
import 'package:e_commerce/src/cart/cart_controller.dart';
import 'package:e_commerce/src/cart/cart_view.dart';
import 'package:e_commerce/src/categories/categories_controller.dart';
import 'package:e_commerce/src/product_details/product_details_view.dart';
import 'package:e_commerce/src/products/products_controller.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});
  @override 
  Widget build(BuildContext context) {
    
    final controller = Get.put(ProductController());
    final categoryController = Get.put(CategoryController());
    final cartcontroller = Get.put(CartController());

    return Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Category Item'),
          actions: [
            Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: badge.Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    badgeContent: cartcontroller.quantity() > 0
                        ? Text(
                            cartcontroller.quantity().toString(),
                            style: const TextStyle(color: Colors.white),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartView(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: Get.isDarkMode ? Colors.black : mainColor,
        ),
        body: Obx(() {
          if (categoryController.isAllCategoryLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Get.isDarkMode ? pinkColor : mainColor,
              ),
            );
          } else {
            return GridView.builder(
                itemCount: categoryController.categoryList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 6,
                  maxCrossAxisExtent: 300,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildCardItem(
                    image: categoryController.categoryList[index].image,
                    price: categoryController.categoryList[index].price,
                    rating:
                        categoryController.categoryList[index].rating?.rate ??
                            3.0,
                    productId: categoryController.categoryList[index].id,
                    productModels: categoryController.categoryList[index],
                    onTap: () {
                      Get.to(() => ProductDetailsView(
                            productModels: controller.productList[index],
                          ));
                    },
                    //controller.productList[index]
                  );
                });
          }
        }));
  }

  Widget buildCardItem({
    required String image,
    required double price,
    required double rating,
    required int productId,
    required ProductModels productModels,
    required Function() onTap,
  }
      //ProductModels model
      ) {
    final controller = Get.put(ProductController());
    final cartcontroller = Get.put(CartController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.manageFavorites(productId);
                        },
                        icon: controller.isFavorites(productId)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                              )),
                    Obx(() {
                      bool isInCart =
                          cartcontroller.productsMap.containsKey(productModels);

                      return IconButton(
                        onPressed: isInCart
                            ? null
                            : () {
                                cartcontroller.addProductToCart(productModels);
                              },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: isInCart ? Colors.grey : Colors.black,
                        ),
                      );
                    }),
                  ],
                );
              }),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Image.network(
                  image,
                  // fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      price.toString(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      width: 45,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextUtils(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              text: rating.toString(),
                              color: Colors.white,
                              underline: TextDecoration.none,
                            ),
                            const Icon(
                              Icons.star,
                              size: 13,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
