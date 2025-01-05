import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';

class ProductsSerivce {
  Future<Map<String, dynamic>> getProducts() async {
    final response = await DioHelper().get(ApiPath.products);
    if (response?.data == null) return {};

    return response!.data;
  }
}
