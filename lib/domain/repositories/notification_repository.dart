import '../entities/NotificationItem.dart';

abstract class NotificationRepository {
  Future<List<NotificationItem>> getNotifications();
}
