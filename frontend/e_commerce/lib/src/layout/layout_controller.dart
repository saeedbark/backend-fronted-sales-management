
import 'package:e_commerce/src/Favorites/favorite_view.dart';
import 'package:e_commerce/src/category/category_view.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:e_commerce/src/setting/setting_view.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  RxInt currentIndex = 0.obs;
  final tabs =  [
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ].obs;
  final title = [
    'Saeed Shop',
    'Categories',
    'Favorites',
    'Setting',
  ].obs;
}