import 'package:e_commerce/src/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  

 const  RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
  final RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller:controller. phoneController, // Add phone field
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.register(
                       controller. nameController.text,
                       controller. emailController.text,
                       controller. passwordController.text,
                       controller. phoneController.text, // Add phone field
                      );
                    },
                    child: const Text('Register'),
                  )),
            TextButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}