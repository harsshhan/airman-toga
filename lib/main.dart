import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/shell/app_shell.dart';
import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';
import 'features/alerts/data/repository/alerts_repository.dart';
import 'features/alerts/data/service/alerts_service.dart';
import 'features/alerts/provider/alerts_provider.dart';
import 'features/auth/data/repository/auth_repository.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/screen/login_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/dashboard/data/repository/dashboard_repository.dart';
import 'features/dashboard/data/service/dashboard_service.dart';
import 'features/dashboard/provider/dashboard_provider.dart';
import 'features/logbook/data/repository/logbook_repository.dart';
import 'features/logbook/data/service/logbook_service.dart';
import 'features/logbook/provider/logbook_provider.dart';
import 'features/study/data/repository/study_repository.dart';
import 'features/study/data/service/study_service.dart';
import 'features/study/provider/study_provider.dart';
import 'features/notes/data/model/study_note.dart';
import 'features/notes/data/model/sync_status.dart';
import 'features/notes/data/repository/notes_repository.dart';
import 'features/notes/data/local/notes_hive_service.dart';
import 'features/notes/data/remote/notes_api_service.dart';
import 'features/notes/provider/notes_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SyncStatusAdapter());
  Hive.registerAdapter(StudyNoteAdapter());
  await Hive.openBox<StudyNote>('study_notes_box');

  final localStorage = LocalStorage();

  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            repository: AuthRepository(
              authService: AuthService(),
              localStorage: localStorage,
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => DashboardProvider(
            repository: DashboardRepository(
              dashboardService: DashboardService(),
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => StudyProvider(
            repository: StudyRepository(
              studyService: StudyService(),
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => LogbookProvider(
            repository: LogbookRepository(
              logbookService: LogbookService(),
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => AlertsProvider(
            repository: AlertsRepository(
              alertsService: AlertsService(),
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => NotesProvider(
            repository: NotesRepository(
              localService: NotesHiveService(),
              remoteService: NotesApiService(),
            ),
          ),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'TOGA',

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,

        themeMode: ThemeMode.system,

        initialRoute: "/",

        routes: {
          "/": (context) => const LoginScreen(),

          "/shell": (context) => const AppShell(),
        },
      ),
    );
  }
}
