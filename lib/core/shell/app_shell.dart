import 'package:flutter/material.dart';

import '../../features/alerts/presentation/screen/alerts_screen.dart';
import '../../features/dashboard/presentation/screen/dashboard_screen.dart';
import '../../features/logbook/presentation/screen/logbook_screen.dart';
import '../../features/notes/presentation/screen/notes_screen.dart';
import '../../features/study/presentation/screen/study_screen.dart';
import '../widget/app_bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {

  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    StudyScreen(),
    NotesScreen(),
    LogbookScreen(),
    AlertsScreen(),
  ];

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
