// import 'package:e_commerce/src/auth/otp/enter_otp/enter_otp_controller.dart';
// import 'package:e_commerce/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';

// class EnterOtpView extends StatelessWidget {
//   const EnterOtpView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(EnterOtpController());

//     const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
//     const fillColor = Color.fromRGBO(243, 246, 249, 0);
//     const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(color: borderColor),
//       ),
//     );

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: context.theme.scaffoldBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: Get.isDarkMode ? blackColor : Colors.white,
//           elevation: 0,
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: controller.formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Enter OTP',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.deepOrange,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: Pinput(
//                       controller: controller.pinController,
//                       focusNode: controller.focusNode,
//                       defaultPinTheme: defaultPinTheme,
//                       separatorBuilder: (index) => const SizedBox(width: 8),
//                       validator: (value) {
//                         if (value == null || value.length < 4) {
//                           return 'Enter a valid OTP';
//                         }
//                         return null;
//                       },
//                       hapticFeedbackType: HapticFeedbackType.lightImpact,
//                       onCompleted: (pin) {
//                         controller.verifyOtp();
//                       },
//                       cursor: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 9),
//                             width: 22,
//                             height: 1,
//                             color: focusedBorderColor,
//                           ),
//                         ],
//                       ),
//                       focusedPinTheme: defaultPinTheme.copyWith(
//                         decoration: defaultPinTheme.decoration!.copyWith(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: focusedBorderColor),
//                         ),
//                       ),
//                       submittedPinTheme: defaultPinTheme.copyWith(
//                         decoration: defaultPinTheme.decoration!.copyWith(
//                           color: fillColor,
//                           borderRadius: BorderRadius.circular(19),
//                           border: Border.all(color: focusedBorderColor),
//                         ),
//                       ),
//                       errorPinTheme: defaultPinTheme.copyWith(
//                         decoration: defaultPinTheme.decoration!.copyWith(
//                           border: Border.all(color: Colors.redAccent),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Obx(() {
//                     return AuthButton(
//                       onPress: controller.verifyOtp,
//                       text: controller.isLoading.value ? 'Verifying...' : 'Verify OTP',
//                       isLoading: controller.isLoading.value,
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
