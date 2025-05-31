import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:provider/provider.dart';

import '../../controllers/rewards_list_provider.dart';

class RewardsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RewardsListProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('Rewards List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: provider.rewards.length,
          itemBuilder: (context, index) {
            final reward = provider.rewards[index];
            return Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(child: Text(reward.merchantName[0])),
                title: Text('You earned ${reward.points} points'),
                subtitle: Text(reward.description),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary_shade,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('+${reward.points}', style: const TextStyle(color: Colors.white)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
