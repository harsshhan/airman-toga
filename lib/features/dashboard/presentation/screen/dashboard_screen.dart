import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/shell/app_shell.dart';
import '../../provider/dashboard_provider.dart';
import '../widgets/continue_study_button.dart';
import '../widgets/dashboard_header_widget.dart';
import '../widgets/fto_instructor_row.dart';
import '../widgets/logbook_preview_card.dart';
import '../widgets/notifications_card.dart';
import '../widgets/stats_row_widget.dart';
import '../widgets/study_progress_card.dart';
import '../widgets/upcoming_flight_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(DashboardProvider provider) {
    if (provider.dashboardData == null) {
      if (provider.error != null) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.textHint,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                provider.error!,
                style: const TextStyle(color: AppColors.textHint),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    context.read<DashboardProvider>().fetchDashboard(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.textwhite,
        ),
      );
    }

    final data = provider.dashboardData!;

    return Column(
      children: [
        Container(
          color: AppColors.primarybackground,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  DashboardHeaderWidget(data: data),
                  const SizedBox(height: 12),
                  StatsRowWidget(data: data),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.whitebackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  children: [
                    StudyProgressCard(
                      data: data,
                      onTap: () => context.findAncestorStateOfType<AppShellState>()?.setIndex(1),
                    ),

                    const SizedBox(height: 14),

                    UpcomingFlightCard(
                      flight: data.upcomingFlight,
                      onTap: () {},
                    ),

                    const SizedBox(height: 14),

                    FtoInstructorRow(
                      data: data,
                      onFtoTap: () {},
                      onInstructorTap: () {},
                    ),

                    const SizedBox(height: 14),

                    LogbookPreviewCard(
                      logbook: data.logbook,
                      onViewAll: () => context.findAncestorStateOfType<AppShellState>()?.setIndex(3),
                    ),

                    const SizedBox(height: 14),

                    NotificationsCard(
                      unreadCount: 3,
                      subtitle: 'Flight reminder · Instructor feedback',
                      onTap: () => context.findAncestorStateOfType<AppShellState>()?.setIndex(4),
                    ),

                    const SizedBox(height: 20),

                    ContinueStudyButton(
                      onPressed: () => context.findAncestorStateOfType<AppShellState>()?.setIndex(1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}