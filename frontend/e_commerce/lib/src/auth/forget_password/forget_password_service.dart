import 'package:e_commerce/network/api_path.dart';
import 'package:e_commerce/network/dio_client.dart';

class PasswordResetService {
  Future<Map<String, dynamic>> requestOTP(String email) async {
    final response = await DioHelper().post(
      ApiPath.passwordResetRequest,
      data: {
        "email": email,
      },
    );
    if (response?.data == null) return {};

    final data = response!.data;

    // await SharedPreferencesHelper.setString('token', data['data']['token']);

    return data;
  }

  Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    final response = await DioHelper().post(
      ApiPath.verifyOtp,
      data: {
        "email": email,
        "otp": otp,
      },
    );
    if (response?.data == null) return {};

    final data = response!.data;

    // await SharedPreferencesHelper.setString('token', data['data']['token']);

    return data;
  }

  Future<Map<String, dynamic>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    final response = await DioHelper().post(
      ApiPath.resetPassword,
      data: {
        "email": email,
        "otp": otp,
        "new_password": newPassword,
      },
    );
    if (response?.data == null) return {};

    final data = response!.data;

    // await SharedPreferencesHelper.setString('token', data['data']['token']);

    return data;
  }
}
