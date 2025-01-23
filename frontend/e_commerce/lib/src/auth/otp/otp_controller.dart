// controllers/otp_controller.dart
import 'package:e_commerce/network/dio_client.dart';
import 'package:e_commerce/src/products/products_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/network/app_exceptions.dart';

class OtpController extends GetxController {
  // Controllers
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  // Form Keys
  final phoneFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  // State Variables
  var isLoading = false.obs;
  var isOtpSent = false.obs;
  var sentOtp = ''.obs; // Stores the OTP returned from the server


  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // Send OTP Function
  Future<void> sendOtp() async {
    if (!phoneFormKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
        final response = await DioHelper().post(
            'https://chinguisoft.com/api/sms/validation/7tOnhf3Zo4L6xx86',
            data: {
                'phone': phoneController.text.trim(),
                'lang': 'fr',
            },
            headers: {
                'Validation-token':'QxRzfuU8KdRND69F77W6IC0JXM1PQdUa',
                'Content-Type': 'application/json',

            }
        );

        if( response?.data['code'] != null){
          sentOtp.value =  response?.data['code'].toString() ??'';
          isOtpSent.value = true;
        }
      else {
       response?.data['error'] ?? 'Failed to send OTP';
       
      }
    } catch (e, stacktrace) {
      if (e is AppException) {
     
      } 
      // Log the exception details for debugging
      print('Exception: $e, Stacktrace: $stacktrace');
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP Function
  Future<void> verifyOtp(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) return;

    // Compare the sent OTP with the user-entered OTP
    if (sentOtp.value == otpController.text.trim()) {
Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductsView()))  ;   
    }
  }
}
