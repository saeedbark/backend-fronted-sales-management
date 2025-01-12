import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/categories/categories_controller.dart';
import 'package:e_commerce/src/products_category/products_view.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(
      () {
        if (controller.isCategoryLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkColor : mainColor,
            ),
          );
        } else {
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                   context.push(AppRoutes.prouductsCategory);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsCategoryView()));
                  },
                 
                  child: Container(
                    height: 200,
                  
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.categoriesList[index].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            controller.categoriesList[index].name,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              backgroundColor: Colors.black38,
                            ),
                          ),),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: controller.categoriesList.length,
            ),
          );
        }
      },
    );
  }
}