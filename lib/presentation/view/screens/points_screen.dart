import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../controllers/points_provider.dart';
import '../widgets/rewards_list_widget.dart';

class PointsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PointsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          color: Colors.white38,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Total Points: ${provider.points!.total}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    buildPointBox('Withdrawal\nPoints', provider.points!.withdrawal),
                    buildPointBox('Remaining\nPoints', provider.points!.remaining),
                    buildPointBox('Pending\nPoints', provider.points!.pending),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Recent Activity',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RewardsListWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPointBox(String title, int value) {
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
