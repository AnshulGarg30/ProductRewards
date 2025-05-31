import 'package:flutter/material.dart';
import 'package:productreward/presentation/controllers/LoginController.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/validators.dart';
import '../../themes/colors.dart';
import 'HomeScreen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_button.dart';
import 'LoginScreen.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Navigate or trigger use case
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
            (Route<dynamic> route) => false, // removes all previous routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    return Scaffold(
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
                          const SizedBox(height: 40),
                          const Text(
                            "Create account",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Enter your details to create your account",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: nameController,
                            label: "Name",
                            validator: validateRequired,
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: confirmPasswordController,
                            label: "Confirm Password",
                            obscureText: true,
                            validator: (value) {
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                              // SocialLoginButton(
                              //   icon: Icons.g_mobiledata,
                              //   text: "Google",
                              //   onPressed: () {
                              //     // Trigger Google Sign-In
                              //   },
                              // ),
                              // const SizedBox(width: 12),
                              // SocialLoginButton(
                              //   icon: Icons.apple,
                              //   text: "Apple",
                              //   onPressed: () {
                              //     // Trigger Apple Sign-In
                              //   },
                              // ),
                          //   ],
                          // ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // Navigate to login
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => LoginScreen()),
                                );
                              },
                              child: const Text("Already have an account? Log in"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      await controller.login();
                      _submitForm;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Create account",
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
