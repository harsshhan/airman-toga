import 'dart:convert';
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

    await prefs.remove(_isLoggedInKey);
    await prefs.remove("cadet_profile");
  }

  Future<void> saveCadetProfile(CadetProfile user) async {
      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        "cadet_profile",
        jsonEncode(user.toJson()),
      );
  }

  Future<CadetProfile?> getCadetProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileStr = prefs.getString("cadet_profile");
    if (profileStr == null) return null;
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(profileStr) as Map<String, dynamic>;
      return CadetProfile.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }
}