import '../../domain/entities/NotificationItem.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasource/mock_notification_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final MockNotificationDataSource dataSource;

  NotificationRepositoryImpl(this.dataSource);

  @override
  Future<List<NotificationItem>> getNotifications() => dataSource.fetchNotifications();
}
