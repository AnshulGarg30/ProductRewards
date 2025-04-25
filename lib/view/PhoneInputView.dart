import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/AuthViewModel.dart';
import 'OTPView.dart';

class PhoneInputView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone Number", prefixText: "+91 "),
            ),
            SizedBox(height: 20),
            authVM.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                await authVM.sendOTP(phoneController.text.trim(), context);
                if (authVM.isOTPSent) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OTPView()),
                  );
                }
              },
              child: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
