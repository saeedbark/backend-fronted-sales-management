import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/src/auth/otp/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{

  final otp = ''.obs;

  final formKey = GlobalKey<FormState>();
  
  final otpController = TextEditingController();



  Future<void> sendOtp(String phoneNumber) async {
   // use try
    final response = await OtpService().sendOtp(phoneNumber);
    if(response['status'] == 'success'){
      otp.value = response['otp'];
    }
  }

void pushToEnterOtp()  {
    // use try
   AppRoutes.router.go(AppRoutes.enterOtp);
  }
}