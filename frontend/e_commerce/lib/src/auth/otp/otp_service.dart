import 'package:e_commerce/network/dio_client.dart';

class OtpService {

    Future<Map<String,dynamic>> sendOtp(String phoneNumber) async {

        final response = await DioHelper().post(
            'https://chinguisoft.com/api/sms/validation/FoaXSIcUccTdGtEo',
            data: {
                'phoneNumber': phoneNumber,
            },
            headers: {
                'Validation-token':'0WomNof4civsTbT2UlUTSYSqYh2HTK0M',
                'Content-Type': 'application/json',

            }
        );

        if (response == null) return {};
        

      return response.data;
      
    }
}