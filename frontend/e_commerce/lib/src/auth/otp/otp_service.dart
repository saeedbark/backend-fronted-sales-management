import 'package:e_commerce/network/dio_client.dart';

class OtpService {

    Future<Map<String,dynamic>> sendOtp(String phoneNumber) async {

        final response = await DioHelper().post(
            'https://chinguisoft.com/api/sms/validation/7tOnhf3Zo4L6xx86',
            data: {
                'phone': phoneNumber,
                'lang': 'fr',
            },
            headers: {
                'Validation-token':'QxRzfuU8KdRND69F77W6IC0JXM1PQdUa',
                'Content-Type': 'application/json',

            }
        );

        if (response == null) return {};
        

      return response.data;
      
    }
}