import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/features/auth/presentation/controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  // final authController = Get.find<AuthController>();
  AuthController authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.register(
                  _emailController.text,
                  _passwordController.text,
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
