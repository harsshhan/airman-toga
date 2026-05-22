import 'package:airman_toga/features/auth/data/model/cadet_profile.dart';
import 'package:airman_toga/features/auth/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';


class AuthProvider
    extends ChangeNotifier {

  final AuthRepository repository;

  AuthProvider({
    required this.repository,
  });

  bool isLoading = false;

  CadetProfile? currentUser;

  String? error;

  Future<void> login() async {

    try {

      isLoading = true;

      notifyListeners();

      currentUser =
          await repository.login();

    } catch(e){

      error =
      "Login failed";

    }

    isLoading = false;

    notifyListeners();
  }
}