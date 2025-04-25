import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productreward/view/CreateAccountScreen.dart';
import 'package:productreward/viewmodels/AuthViewModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: MaterialApp(
        title: 'Phone Auth',
        home: CreateAccountScreen(),
      ),
    );
  }
}