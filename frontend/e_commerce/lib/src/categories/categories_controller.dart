import 'package:e_commerce/network/app_exceptions.dart';
import 'package:e_commerce/src/categories/categories_model.dart';
import 'package:e_commerce/src/categories/categories_service.dart';
import 'package:e_commerce/src/products/products_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categoriesList = [];
  var categoryList = <ProductModels>[].obs;
  final isCategoryLoading = false.obs;
  // var categoryList = <ProductModels>[].obs;
  var isAllCategoryLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void getCategories() async {
    isCategoryLoading(true);

    try {
      final categories = await CategoryService().getCategories();
      isCategoryLoading(false);
      categoriesList = categories;
    } on AppException catch (e) {
      isCategoryLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getProductsByCategory(int id) async {
    isCategoryLoading(true);

    categoryList.clear();
    try {
      final products = await CategoryService().getProductsByCategory(id);
      isCategoryLoading(false);
      categoryList.value = products;
    } on AppException catch (e) {
      isCategoryLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }
}
