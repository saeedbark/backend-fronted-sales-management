import 'package:badges/badges.dart' as badge;
import 'package:badges/badges.dart';
import 'package:e_commerce/src/cart/cart_controller.dart';
import 'package:e_commerce/src/cart/cart_view.dart';
import 'package:e_commerce/src/layout/layout_controller.dart';
import 'package:e_commerce/src/notification/notification_controller.dart';
import 'package:e_commerce/src/notification/notification_view.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart' hide Badge;

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LayoutController());
    final cartController = Get.put(CartController());
    return SafeArea(
      child: Obx(
        () {
          return Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              leading: Container(),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: badge.Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    badgeContent: cartController.quantity() > 0
                        ? Text(
                            cartController.quantity().toString(),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: badge.Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    badgeContent: cartController.quantity() > 0
                        ? Text(
                            Get.put(NotificationController())
                                .notifications
                                .length
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () => Get.to(() => const NotificationView()),
                      icon: const Icon(
                        Icons.notification_add_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
                  icon: Icon(
                    Icons.home,
                    color: Get.isDarkMode ? Colors.white : blackColor,
                  ),
                  label: 'Products',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.category,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(
                    Icons.category,
                    color: Get.isDarkMode ? Colors.white : blackColor,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.favorite,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(
                    Icons.favorite,
                    color: Get.isDarkMode ? Colors.white : blackColor,
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.settings,
                    color: Get.isDarkMode ? pinkColor : mainColor,
                  ),
                  icon: Icon(
                    Icons.settings,
                    color: Get.isDarkMode ? Colors.white : blackColor,
                  ),
                  label: 'Setting',
                ),
              ],
              onTap: (index) {
                controller.currentIndex.value = index;
              },
            ),
            body: IndexedStack(
              index: controller.currentIndex.value,
              children: controller.tabs,
            ),
          );
        },
      ),
    );
  }
}
