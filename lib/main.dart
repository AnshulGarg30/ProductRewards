import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Required for RouteObserver
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productreward/presentation/controllers/HistoryProvider.dart';
import 'package:productreward/presentation/controllers/LoginController.dart';
import 'package:productreward/presentation/controllers/RedeemRequestProvider.dart';
import 'package:productreward/presentation/controllers/UserProvider.dart';
import 'package:productreward/presentation/controllers/catelog_controller.dart';
import 'package:productreward/presentation/controllers/product_controller.dart';
import 'package:productreward/presentation/controllers/rewards_list_provider.dart';
import 'package:productreward/presentation/view/screens/HomeScreen.dart';
import 'package:productreward/presentation/view/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/auth_local_datasource.dart';
import 'data/repositories/auth_login_repository_impl.dart';
import 'domain/usecases/check_login_status.dart';
import 'domain/usecases/set_login_status.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

/// Global RouteObserver for tracking route changes
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Initialize and handle Firebase Messaging token
  await FirebaseMessagingService().initialize();

  final authLocalDataSource = AuthLocalDataSource();
  final authLoginRepo = AuthLoginRepositoryImpl(authLocalDataSource);
  final checkLogin = CheckLoginStatus(authLoginRepo);
  final setLogin = SetLoginStatus(authLoginRepo);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginController(
            checkLoginStatus: checkLogin,
            setLoginStatus: setLogin,
          )..init(),
        ),
        ChangeNotifierProvider(create: (_) => ProductController()..fetchProducts()),
        ChangeNotifierProvider(create: (_) => CatelogController()..fetchCatelogs()),
        ChangeNotifierProvider(create: (_) => RewardsListProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => Redeemrequestprovider()),
      ],
      child: MyApp(),
    ),
  );
}

class FirebaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const _tokenKey = 'firebase_messaging_token';

  Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      print('FCM Token: $token');

      if (token != null) {
        await _saveTokenSecurely(token);
      }
    } else {
      print('User declined or has not accepted permission for notifications');
    }
  }

  Future<void> _saveTokenSecurely(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    print('Token saved securely');
  }

  Future<String?> getTokenSecurely() async {
    return await _secureStorage.read(key: _tokenKey);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, controller, _) {
        print("isLoggedin ${controller.isLoggedIn}");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: controller.isLoggedIn ? HomeScreen() : LoginScreen(),
          navigatorObservers: [routeObserver], // 🔹 Register RouteObserver
        );
      },
    );
  }
}
