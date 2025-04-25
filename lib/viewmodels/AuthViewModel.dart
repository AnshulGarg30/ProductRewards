import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;
  bool isOTPSent = false;
  bool isLoading = false;

  String? get verificationId => _verificationId;

  Future<void> sendOTP(String phoneNumber, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
        isLoading = false;
        notifyListeners();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        isOTPSent = true;
        isLoading = false;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTP(String otp, BuildContext context) async {
    if (_verificationId == null) return;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successful!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }
  }
}
