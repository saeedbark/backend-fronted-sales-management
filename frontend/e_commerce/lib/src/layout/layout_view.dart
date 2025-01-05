import 'package:badges/badges.dart' as badge;
import 'package:badges/badges.dart';
import 'package:e_commerce/src/layout/layout_controller.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart' hide Badge;



class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final controller = Get.find<LayoutController>();
  //final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () {
          return Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              leading: Container(),
              actions: [
              Obx(() {
                return   Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: badge.Badge(
                  //  badgeColor: Colors.red,
                    position: BadgePosition.topEnd(top: 0, end: 3),
                   // animationDuration: const Duration(milliseconds: 300),
                  //  animationType: BadgeAnimationType.slide,
                    badgeContent:  Text(
                     //cartController.quantity().toString(),
                     '0',
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () {
                       // Get.toNamed(Routes.cartScreen);
                      },
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ),
                );

              }
              ,),
              ],
              title: Text(controller.title[controller.currentIndex.value]),
              centerTitle: true,
              backgroundColor: Get.isDarkMode ? blackColor : mainColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Get.isDarkMode ? blackColor : Colors.white,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(Icons.home,
                      color: Get.isDarkMode ? Colors.white : blackColor),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.category,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(Icons.category,
                      color: Get.isDarkMode ? Colors.white : blackColor),
                  label: 'Products',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.favorite,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(Icons.favorite,
                      color: Get.isDarkMode ? Colors.white : blackColor),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.settings,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(Icons.settings,
                      color: Get.isDarkMode ? Colors.white : blackColor),
                  label: 'Setting',
                ),
              ],
              onTap: (index) {
                controller.currentIndex.value = index;
              },
            ),
            body: IndexedStack(
              index: controller.currentIndex.value,
              children: controller.tabs.value,
            ),
          );
        },
      ),
    );
  }
}