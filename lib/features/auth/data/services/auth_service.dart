

import 'package:airman_toga/core/mock_data/auth_mock_data.dart';
import 'package:airman_toga/features/auth/data/model/cadet_profile.dart';

class AuthService {
  Future<CadetProfile> login() async {

    // simulate API delay
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return CadetProfile.fromJson(
      MockCadetProfile.profile.toJson(),
    );
  }
}