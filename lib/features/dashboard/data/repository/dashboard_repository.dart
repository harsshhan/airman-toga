import 'package:airman_toga/features/dashboard/data/model/dashboard_data.dart';
import 'package:airman_toga/features/dashboard/data/service/dashboard_service.dart';

class DashboardRepository {

  final DashboardService dashboardService;

  DashboardRepository({
    required this.dashboardService,
  });

  Future<DashboardData> fetchDashboard() async {

    return await dashboardService.fetchDashboard();
  }
}
