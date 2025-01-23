// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EnterOtpController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   final pinController = TextEditingController();
//   final focusNode = FocusNode();
//   final isLoading = false.obs;

//   @override
//   void onClose() {
//     pinController.dispose();
//     focusNode.dispose();
//     super.onClose();
//   }

//      Future<void> verifyOtp() async {
//     if (!formKey.currentState!.validate()) return;

//     isLoading.value = true;
//     try {
//       final phone = Get.arguments['phone'] as String;
//       final response = await OtpService().verifyOtp(phone, pinController.text.trim());
//       if (response['status'] == 'success') {
//         Get.offAllNamed(AppRoutes.home);
//       } else {
//         Get.snackbar('Error', response['message'] ?? 'Invalid OTP',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
   
//    }


