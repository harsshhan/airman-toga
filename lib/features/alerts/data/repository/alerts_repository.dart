import 'package:airman_toga/features/alerts/data/model/notification_item.dart';
import 'package:airman_toga/features/alerts/data/service/alerts_service.dart';

class AlertsRepository {
  final AlertsService alertsService;

  AlertsRepository({required this.alertsService});

  Future<List<NotificationItem>> fetchNotifications() async {
    return await alertsService.fetchNotifications();
  }
}
