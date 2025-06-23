import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productreward/presentation/themes/colors.dart';
import '../../controllers/UserProvider.dart';
import '../../controllers/rewards_list_provider.dart';

class Rewardlist extends StatefulWidget {
  @override
  State<Rewardlist> createState() => _RewardlistState();
}

class _RewardlistState extends State<Rewardlist> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RewardsListProvider>(context, listen: false).fetchRewards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Consumer<RewardsListProvider>(
      builder: (context, rewardsProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Reward Items'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Container(
              color: Colors.white38,
              child: _buildBody(rewardsProvider, userProvider),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(RewardsListProvider provider, UserProvider userProvider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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

    return ListView.builder(
      itemCount: provider.rewards.length,
      padding: const EdgeInsets.only(top: 16),
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

                final result = await provider.redeemReward(
                  reward.id.toString(),
                  userId,
                  userProvider,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result['message']),
                    backgroundColor:
                    result['success'] ? Colors.green : Colors.red,
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
    );
  }
}
