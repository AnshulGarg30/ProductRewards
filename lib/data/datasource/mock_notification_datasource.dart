import '../../domain/entities/NotificationItem.dart';

class MockNotificationDataSource {
  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(Duration(milliseconds: 300));
    return [
      NotificationItem(
        id: '1',
        title: 'Points Earned!',
        message: 'You earned 50 points from Starbucks.',
        date: DateTime.now().subtract(Duration(hours: 2)),
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        title: 'Weekly Summary',
        message: 'Here’s your points activity for this week.',
        date: DateTime.now().subtract(Duration(days: 1)),
        isRead: true,
      ),
    ];
  }
}
