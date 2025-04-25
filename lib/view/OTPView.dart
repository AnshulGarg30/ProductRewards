import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/AuthViewModel.dart';

class OTPView extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "OTP"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authVM.verifyOTP(otpController.text.trim(), context);
              },
              child: Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
