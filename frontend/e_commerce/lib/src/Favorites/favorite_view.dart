import 'package:e_commerce/src/products/products_controller.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.favoritesList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 90,
                  color: Colors.grey.shade400,
                ),
                Text(
                  'Please,Add your favorites products.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Get.isDarkMode ? Colors.white : Colors.grey.shade600,
                  ),
                )
              ],
            ),
          );
        } else {
          return ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
              image: controller.favoritesList[index].image,
              title: controller.favoritesList[index].title,
              price: controller.favoritesList[index].price,
              productId: controller.favoritesList[index].id,
            ),
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            itemCount: controller.favoritesList.length,
          );
        }
      }),
    );
  }

  Widget buildFavItem({
    required String image,
    required String title,
    required String price,
    required int productId,
  }) {
    final controller = Get.put(ProductController());

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white : blackColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    price.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white : blackColor),
                  )
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  controller.manageFavorites(productId);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
