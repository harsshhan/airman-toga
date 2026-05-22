import 'package:airman_toga/features/dashboard/data/model/dashboard_data.dart';
import 'package:airman_toga/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {

  final DashboardRepository repository;

  DashboardProvider({
    required this.repository,
  });

  bool isLoading = false;

  DashboardData? dashboardData;

  String? error;

  Future<void> fetchDashboard() async {

    try {

      isLoading = true;
      notifyListeners();

      dashboardData = await repository.fetchDashboard();

    } catch (e) {

      error = 'Failed to load dashboard';
    }

    isLoading = false;
    notifyListeners();
  }
}
