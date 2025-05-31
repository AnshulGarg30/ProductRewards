import 'package:flutter/material.dart';
import '../../domain/entities/NotificationItem.dart';
import '../../domain/usecases/get_notifications_usecase.dart';

class NotificationProvider extends ChangeNotifier {
  final GetNotificationsUseCase useCase;

  List<NotificationItem> notifications = [];
  bool isLoading = true;

  NotificationProvider(this.useCase) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading = true;
    notifyListeners();
    notifications = await useCase();
    isLoading = false;
    notifyListeners();
  }
}
