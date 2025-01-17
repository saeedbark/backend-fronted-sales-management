import 'package:e_commerce/src/products/products_controller.dart';
import 'package:e_commerce/src/widget/text_util.dart';
import 'package:e_commerce/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import 'package:get/get.dart';

class ClothesInfo extends StatelessWidget {
  final String title;
  final int producId;
  final double rate;
  final String description;
  const ClothesInfo({
    super.key,
    required this.title,
    required this.producId,
    required this.rate,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Colors.grey.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.manageFavorites(producId);
                    },
                    child: controller.isFavorites(producId)
                        ? const Icon(
                            Icons.favorite,
                            size: 20,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextUtils(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                text: '$rate',
                color: Get.isDarkMode ? Colors.white : Colors.black,
                underline: TextDecoration.none,
              ),
              const SizedBox(width: 8),
              RatingBarIndicator(
                rating: rate,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ReadMoreText(
            description,
            trimLines: 3,
            textAlign: TextAlign.justify,
            // trimMode: TrimMode.Line,
            style: TextStyle(
              fontSize: 16,
              height: 2,
              color: Get.isDarkMode ? Colors.white : blackColor,
            ),
            trimCollapsedText: ' Show more',
            trimExpandedText: ' Show less',
            trimMode: TrimMode.Line,
            moreStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? pinkColor : mainColor,
            ),
            lessStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? pinkColor : mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
