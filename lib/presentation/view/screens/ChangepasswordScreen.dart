import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productreward/presentation/view/screens/LoginScreen.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/validators.dart';
import '../../themes/colors.dart';
import '../widgets/custom_text_field.dart';

class ChangepasswordScreen extends StatefulWidget {
  final String? userID;
  const ChangepasswordScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  void _resetPassword(BuildContext context) async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      if (newPassword != confirmPassword) {
        setState(() {
          errorMessage = "Passwords do not match";
        });
        return;
      }

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final api = ApiService();
      // setState(() => isLoading = false);
      final changeResponse = await api.change_Password(widget.userID.toString(), newPassword,oldPassword);
      setState(() => isLoading = false);

      if(changeResponse.statusCode == 200) {
        final data = jsonDecode(changeResponse.body);
        if (data['status'] == true) {
          Fluttertoast.showToast(msg: "${data['message']}");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Change failed: ${data['message']}',
            backgroundColor: Colors.red,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed: ${changeResponse.statusCode}',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Text(
          'Reset Password',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background.jpg', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Reset your password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter your current and new password.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: oldPasswordController,
                          label: "Old Password",
                          keyboardType: TextInputType.visiblePassword,
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          controller: newPasswordController,
                          label: "New Password",
                          keyboardType: TextInputType.visiblePassword,
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          controller: confirmPasswordController,
                          label: "Confirm Password",
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _resetPassword(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
