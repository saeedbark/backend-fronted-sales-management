import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';
import 'package:e_commerce/src/categories/categories_model.dart';

class CategoryService {
Future<List<CategoryModel>> getCategories() async {
   final response = await DioHelper().get(ApiPath.categories);

   

   if(response == null || response.data['data'] == []) return <CategoryModel>[];

   final categories = response.data['data']['categories'] as List;

    return categories.map((category) => CategoryModel.fromJson(category)).toList();
}
}