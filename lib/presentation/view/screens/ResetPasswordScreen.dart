import 'package:flutter/material.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/validators.dart';
import '../../themes/colors.dart';
import '../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String? confirmPasswordError;

  void _resetPassword(BuildContext context) async {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      if (newPassword != confirmPassword) {
        setState(() {
          confirmPasswordError = "Passwords do not match";
        });
        return;
      }

      setState(() {
        isLoading = true;
        confirmPasswordError = null;
      });

      // final api = ApiService();
      // final response = await api.resetPassword(widget.email, newPassword); // Customize this call
      //
      // setState(() => isLoading = false);
      //
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   Fluttertoast.showToast(msg: "Password reset successful");
      //   Navigator.pop(context); // Or navigate to login screen
      // } else {
      //   Fluttertoast.showToast(
      //     msg: 'Failed: ${response.statusCode}',
      //     backgroundColor: Colors.red,
      //   );
      // }
    }
  }

  @override
  void dispose() {
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
                    "Create new password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter your new password and confirm to complete reset.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _resetPassword(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
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
