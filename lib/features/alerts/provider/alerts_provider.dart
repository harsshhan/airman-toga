import 'package:airman_toga/features/alerts/data/model/notification_item.dart';
import 'package:airman_toga/features/alerts/data/repository/alerts_repository.dart';
import 'package:flutter/material.dart';

class AlertsProvider extends ChangeNotifier {
  final AlertsRepository repository;

  AlertsProvider({required this.repository});

  bool isLoading = false;
  List<NotificationItem> notifications = [];
  String? error;

  Future<void> fetchNotifications() async {
    try {
      isLoading = true;
      notifyListeners();

      notifications = await repository.fetchNotifications();
    } catch (e) {
      error = 'Failed to load notifications';
    }

    isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final old = notifications[index];
      // Create a new instance with isRead: true to enforce immutability rules, although NotificationItem's model doesn't have copyWith, we'll recreate it.
      notifications[index] = NotificationItem(
        id: old.id,
        title: old.title,
        message: old.message,
        type: old.type,
        time: old.time,
        isRead: true,
      );
      notifyListeners();
    }
  }

  void markAllAsRead() {
    notifications = notifications.map((n) {
      return NotificationItem(
        id: n.id,
        title: n.title,
        message: n.message,
        type: n.type,
        time: n.time,
        isRead: true,
      );
    }).toList();
    notifyListeners();
  }
}
