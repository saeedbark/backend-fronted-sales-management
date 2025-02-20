import 'package:e_commerce/network/dio_client.dart';

class OtpService {
  Future<Map<String, dynamic>> sendOtp(String phoneNumber) async {
    final response = await DioHelper().post(
        'https://chinguisoft.com/api/sms/validation/6U6UWxBFGKhHddyw',
        data: {
          'phone': phoneNumber,
          'lang': 'fr',
        },
        headers: {
          'Validation-token': '37mxioo6KDdGtnBwYVRtyhaWalpbLz6O',
          'Content-Type': 'application/json',
        });

    if (response == null) return {};

    return response.data;
  }
}
