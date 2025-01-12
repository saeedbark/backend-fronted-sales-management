import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';
import 'package:e_commerce/shared_pref/shared_preferences.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await DioHelper().post(
      ApiPath.login,
      data: {
        "username": email,
        "password": password,
      },
    );
    if (response?.data == null) return {};

    final data = response!.data;

    await SharedPreferencesHelper.setString('token', data['data']['token']);

    return data;
  }
}
