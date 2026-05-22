import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repository/auth_repository.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/screen/login_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/dashboard/presentation/screen/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

          "/dashboard": (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
