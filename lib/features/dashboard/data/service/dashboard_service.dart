import 'package:airman_toga/core/mock_data/dashboard_mock_data.dart';
import 'package:airman_toga/features/dashboard/data/model/dashboard_data.dart';

class DashboardService {

  Future<DashboardData> fetchDashboard() async {

    await Future.delayed(
      const Duration(seconds: 1),
    );

    return DashboardData.fromJson(
      DashboardMockData.dashboard,
    );
  }
}
