
import 'package:flutter/material.dart';
import 'package:productreward/presentation/controllers/LoginController.dart';
import 'package:productreward/presentation/controllers/notification_provider.dart';
import 'package:productreward/presentation/controllers/points_provider.dart';
import 'package:productreward/presentation/controllers/product_controller.dart';
import 'package:productreward/presentation/controllers/profile_provider.dart';
import 'package:productreward/presentation/controllers/rewards_list_provider.dart';
import 'package:productreward/presentation/view/screens/HomeScreen.dart';
import 'package:productreward/presentation/view/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/auth_local_datasource.dart';
import 'data/datasource/mock_notification_datasource.dart';
import 'data/datasource/mock_reward_datasource.dart';
import 'data/datasource/points_remote_datasource.dart';
import 'data/datasource/user_remote_datasource.dart';
import 'data/repositories/auth_login_repository_impl.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'data/repositories/points_repository_impl.dart';
import 'data/repositories/reward_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/check_login_status.dart';
import 'domain/usecases/get_notifications_usecase.dart';
import 'domain/usecases/get_points_usecase.dart';
import 'domain/usecases/get_rewards_usecase.dart';
import 'domain/usecases/get_user_profile.dart';
import 'domain/usecases/set_login_status.dart';

void main() async {

  final authLocalDataSource = AuthLocalDataSource();
  final authLoginRepo = AuthLoginRepositoryImpl(authLocalDataSource);
  final checkLogin = CheckLoginStatus(authLoginRepo);
  final setLogin = SetLoginStatus(authLoginRepo);

  final dataSource = MockUserRemoteDataSourceImpl();
  final profileRepository = UserRepositoryImpl(dataSource);
  final getUserProfile = GetUserProfile(profileRepository);

  final dataSource_Rewards = MockPointsRemoteDataSource();
  final repository = PointsRepositoryImpl(dataSource_Rewards);
  final useCase = GetPointsUseCase(repository);

  final rewardsUseCase = GetRewardsListUseCase(RewardListRepositoryImpl(MockRewardRecentListDataSource()));


  final dataSource_Notification = MockNotificationDataSource();
  final repository_Notification = NotificationRepositoryImpl(dataSource_Notification);
  final useCase_Notification = GetNotificationsUseCase(repository_Notification);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => LoginController(
          checkLoginStatus: checkLogin,
          setLoginStatus: setLogin,
        )..init(),
      ),
      ChangeNotifierProvider(create: (_) => ProductController()..fetchProducts()),
      ChangeNotifierProvider(create: (_) => ProfileProvider(getUserProfile)),
      ChangeNotifierProvider(create: (_) => PointsProvider(useCase)),
      ChangeNotifierProvider(create: (_) => RewardsListProvider(rewardsUseCase),),
      ChangeNotifierProvider(create: (_) => NotificationProvider(useCase_Notification)),


    ],
    child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
        builder: (context, controller, _) {
          print("isLoggedin ${controller.isLoggedIn}");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: controller.isLoggedIn ? HomeScreen() : LoginScreen(),
          );
        }
    );
  }
}