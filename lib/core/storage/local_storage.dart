import 'package:airman_toga/features/auth/data/model/cadet_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static const _isLoggedInKey = "is_logged_in";

  Future<void> setLoggedIn(bool value) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      _isLoggedInKey,
      value,
    );
  }

  Future<bool> isLoggedIn() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
          _isLoggedInKey,
        ) ??
        false;
  }

  Future<void> clearSession() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      _isLoggedInKey,
    );
  }

  Future<void> saveCadetProfile(CadetProfile user) async {
      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        "cadet_profile",
        user.toJson().toString(),
      );
  }


}