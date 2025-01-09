import 'package:e_commerce/network/dio_client.dart';


class RegisterService {

  Future<Map<String, dynamic>> register(String name, String email, String password, String phone) async {
    final response = await  DioHelper().post(
      'register/',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone, // Add phone field
      },
    );
      if(response?.data == null) return {};  

    return response!.data;
  }
}