import 'package:airman_toga/core/storage/local_storage.dart';
import 'package:airman_toga/features/auth/data/model/cadet_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthRepository {

  final AuthService authService;

  final LocalStorage localStorage;

  AuthRepository({
    required this.authService,
    required this.localStorage,
  });

  Future<CadetProfile> login() async {

    final user =
        await authService.login();

    await localStorage
        .setLoggedIn(true);

    await localStorage
        .saveCadetProfile(user);

    return user;
  }

  Future<void> logout() async {

    await localStorage
        .clearSession();
  }
}