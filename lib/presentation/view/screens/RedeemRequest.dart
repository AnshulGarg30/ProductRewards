import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/RedeemRequestProvider.dart';

class RedeemRequest extends StatefulWidget {
  final String? userID;

  const RedeemRequest({Key? key, required this.userID}) : super(key: key);

  @override
  State<RedeemRequest> createState() => _RedeemRequestState();
}

class _RedeemRequestState extends State<RedeemRequest> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<Redeemrequestprovider>(context, listen: false)
          .fetchRedeemRequest(widget.userID.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redeem Requests')),
      body: Consumer<Redeemrequestprovider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          if (provider.items.isEmpty) {
            return const Center(child: Text('No redeem requests found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              final reward = item.reward;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (reward?.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          reward!.image,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reward?.name ?? 'Unknown Reward',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Points: ${item.point}',
                            style: const TextStyle(color: Colors.black87),
                          ),
                          Text(
                            'Date: ${item.createdAt.split("T")[0]}',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text('Status: ',
                                  style: TextStyle(fontSize: 12)),
                              Text(
                                _getStatusText(item.status),
                                style: TextStyle(
                                  color: _getStatusColor(item.status),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Approved';
      case 2:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
