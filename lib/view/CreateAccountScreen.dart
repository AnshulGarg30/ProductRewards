import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'OtpScreen.dart'; // Update import based on your project structure

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final numericPhone = toNumericString(value);
    if (numericPhone.length < 10 || numericPhone.length > 15) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _handleCreateAccount() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = toNumericString(_controller.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(phoneNumber: '+91$phoneNumber'), // Pass phone
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background.jpg', fit: BoxFit.cover,),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Create account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your phone. We will send a confirmation code.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      validator: validatePhone,
                      inputFormatters: [
                        PhoneInputFormatter(
                          allowEndlessPhone: true,
                          defaultCountryCode: 'IN',
                        )
                      ],
                      decoration: InputDecoration(
                        hintText: "+91 (123) 456-7890",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleCreateAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6E96),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          "Create account",
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
