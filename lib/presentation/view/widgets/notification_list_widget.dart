import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/notification_provider.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: provider.notifications.length,
      itemBuilder: (context, index) {
        final notification = provider.notifications[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Card(
            color: notification.isRead ? Colors.grey[200] : Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(notification.message),
              trailing: Text(
                '${notification.date.hour}:${notification.date.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        );
      },
    );
  }
}
