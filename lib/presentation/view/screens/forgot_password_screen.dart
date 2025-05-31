import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/validators.dart';
import '../../themes/colors.dart';
import '../widgets/custom_text_field.dart';
import 'ResetPasswordScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  bool otpSent = false;
  String? OTPValue = "";
  String? _otpErrorText;
  bool isLoading = false;

  void _handleActionButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        _otpErrorText = null;
      });

      if (!otpSent) {
        await _sendOTP(context);
      } else {
        _verifyOTP(context);
      }

      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _sendOTP(BuildContext context) async {
    final api = ApiService();
    final response = await api.forget_Password(emailController.text);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('OTP sent: $data');
      OTPValue = data['otp'];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset OTP sent!")),
      );

      setState(() {
        otpSent = true;
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to send OTP: ${response.statusCode}',
        backgroundColor: Colors.red,
      );
    }
  }

  void _verifyOTP(BuildContext context) {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      setState(() {
        _otpErrorText = 'Please enter the OTP';
      });
      return;
    }

    // Example check – replace with real logic
    if (otp != OTPValue) {
      setState(() {
        _otpErrorText = 'Invalid OTP. Please try again.';
      });
      return;
    }

    setState(() {
      _otpErrorText = null;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) =>  ResetPasswordScreen()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background.jpg', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Reset your password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Enter the email associated with your account and we'll send a reset link.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 24),
                      if (otpSent)
                        CustomTextField(
                          controller: otpController,
                          label: "Enter OTP",
                          keyboardType: TextInputType.number,
                          errorText: _otpErrorText,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () => _handleActionButton(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : Text(
                      otpSent ? "Verify OTP" : "Send OTP",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
