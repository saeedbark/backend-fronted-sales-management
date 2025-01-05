
import 'package:e_commerce/src/products/products_controller.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/src/widget/home/searchEmpty.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItem extends StatelessWidget {
  CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Obx(() {
      // Only use Obx here to rebuild when `isLoading` changes.
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode ? pinkColor : mainColor,
          ),
        );
      } else {
        return Expanded(
          child: controller.searchList.isEmpty &&
                  controller.searchController.text.isNotEmpty
              ? SearchEmpty()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 6,
                    maxCrossAxisExtent: 300,
                  ),
                  itemCount: controller.searchList.isEmpty
                      ? controller.productList.length
                      : controller.searchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Wrap only the item that changes with `Obx`.
                    return Obx(() {
                      var currentProduct = controller.searchList.isEmpty
                          ? controller.productList[index]
                          : controller.searchList[index];
                      return buildCardItem(
                        image: currentProduct.image,
                        price: currentProduct.price,
                        rating: currentProduct.rating?.rate ?? 0.0,
                        productId: currentProduct.id,
                        productModels: currentProduct,
                        onTap: () {
                          // Handle navigation or other actions
                        },
                      );
                    });
                  },
                ),
        );
      }
    });
  }

  Widget buildCardItem({
    required String image,
    required String price,
    required double rating,
    required int productId,
    required ProductModels productModels,
    required Function() onTap,
  }) {
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
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle favorite action
                      },
                      icon: const Icon(
                        Icons.favorite_outline,  
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle cart action
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
             
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Image.network(image),
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