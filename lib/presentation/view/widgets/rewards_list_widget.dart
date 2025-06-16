import 'package:flutter/material.dart';
import 'package:productreward/presentation/controllers/UserProvider.dart';
import 'package:provider/provider.dart';
import '../../../data/datasource/auth_local_datasource.dart';
import '../../controllers/rewards_list_provider.dart';
import '../../themes/colors.dart';

class RewardsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<RewardsListProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show error message if it exists
    if (provider.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            provider.errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (provider.rewards.isEmpty) {
      return const Center(child: Text('No rewards available.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Rewards List',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.rewards.length,
          itemBuilder: (context, index) {
            final reward = provider.rewards[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(reward.image),
                ),
                title: Text(reward.name),
                subtitle: Text('${reward.point} Points'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final userId = userProvider.userData?.id.toString();
                    if (userId == null || userId.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User not logged in.')),
                      );
                      return;
                    }
                    print("rewardredeem data: ${reward.id} and ${userId}");

                    //api call
                    final result = await provider.redeemReward(reward.id.toString(), userId, userProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result['message']),
                        backgroundColor: result['success'] ? Colors.green : Colors.red,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary_shade,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Redeem'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
