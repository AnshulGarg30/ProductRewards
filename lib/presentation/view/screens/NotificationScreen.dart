import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';

import '../widgets/notification_list_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications',style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white), // Makes back icon white
      ),
      // body: const NotificationListWidget(),
    );
  }
}
