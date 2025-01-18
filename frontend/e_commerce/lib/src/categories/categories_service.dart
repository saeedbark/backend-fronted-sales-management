import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';
import 'package:e_commerce/src/categories/categories_model.dart';
import 'package:e_commerce/src/products/products_model.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    final response = await DioHelper().get(ApiPath.categories);

    if (response == null || response.data['data'] == []) {
      return <CategoryModel>[];
    }

    final categories = response.data['data']['categories'] as List;

    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  Future<List<ProductModels>> getProductsByCategory(int id) async {
    final response =
        await DioHelper().get('${ApiPath.allProductsByCategory}/$id');

    if (response == null || response.data['data'] == []) return <ProductModels>[];

    final products = response.data['data']['products'] as List;

    return products.map((product) => ProductModels.fromJson(product)).toList();
  }
}
