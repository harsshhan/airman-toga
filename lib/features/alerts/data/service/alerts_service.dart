import 'package:airman_toga/core/mock_data/notification_mock_data.dart';
import 'package:airman_toga/features/alerts/data/model/notification_item.dart';

class AlertsService {
  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return (NotificationMockData.notifications as List)
        .map((e) => NotificationItem.fromJson(e))
        .toList();
  }
}
