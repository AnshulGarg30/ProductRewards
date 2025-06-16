import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../controllers/UserProvider.dart';
import '../widgets/rewards_list_widget.dart';

class PointsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white38,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Total Points: ${userProvider.userData?.totalPoint ?? '0'}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    buildPointBox('Withdrawal\nPoints', userProvider.userData?.withdrawalPoint ?? '0'),
                    buildPointBox('Remaining\nPoints', userProvider.userData?.remainingPoint ?? '0'),
                    buildPointBox('Pending\nPoints', userProvider.userData?.pendingPoint ?? '0'),
                  ],
                ),
                const SizedBox(height: 10),
                // Text(
                //   'Recent Activity',
                //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 10),
                RewardsListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPointBox(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.primary_shade,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text('$value', style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
