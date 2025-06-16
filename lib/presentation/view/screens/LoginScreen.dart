import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productreward/presentation/controllers/LoginController.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_service.dart';
import '../../../core/utils/validators.dart';
import '../../../data/datasource/auth_local_datasource.dart';
import '../../../data/models/LoginResponse.dart';
import '../../../main.dart';
import '../../controllers/UserProvider.dart';
import '../../themes/colors.dart';
import 'HomeScreen.dart';
import '../widgets/custom_text_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login(BuildContext context, LoginController controller, UserProvider userProvider) async{

    final service = FirebaseMessagingService();
    String? token = await service.getTokenSecurely();
    print('Retrieved secure token: $token');

    if (_formKey.currentState!.validate()) {
      print('Login data: ${emailController.text} and ${passwordController.text}');
      final api = ApiService();
      final response = await api.login(emailController.text, passwordController.text, token ?? "");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login successful: $data');
        if(data['status'] == true) {
          final loginResponse = LoginResponse.fromJson(data);
          if (loginResponse.status) {
            await controller.login();
            final userData = loginResponse.data;
            userProvider.setUserData(userData);
            print("local user data ${userProvider.loadUserData()}");
            // Navigate to Welcome screen and clear stack
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
                  (route) => false,
            );
          } else {
            Fluttertoast.showToast(
                msg: loginResponse.message, backgroundColor: Colors.red);
          }
        }else {
          Fluttertoast.showToast(
              msg: "${data['message']}", backgroundColor: Colors.red);
        }
      } else {
        print('Login failed: ${response.statusCode}');
        Fluttertoast.showToast(msg: 'Login failed: ${response.statusCode}', backgroundColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background.jpg', fit: BoxFit.cover,),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          const Text(
                            "Log in",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Enter your email and password to log in",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: emailController,
                            label: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: passwordController,
                            label: "Password",
                            obscureText: true,
                            validator: validatePassword,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Forgot password action
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                                );
                              },
                              child: const Text("Forgot password?"),
                            ),
                          ),
                          // const SizedBox(height: 10),
                          // Center(
                          //   child: TextButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(builder: (_) => CreateAccountScreen()),
                          //       );
                          //     },
                          //     child: const Text("Don't have an account? Sign up"),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _login(context, controller, userProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )

    );
  }
}
