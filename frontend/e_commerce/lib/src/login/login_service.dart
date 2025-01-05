

import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';

class LoginService {


  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await DioHelper().post(
      ApiPath.login,
      data: {
        "username": email,
        "password": password,
      },
    );
    if(response?.data == null) return {};  

    return response!.data;
  }
}