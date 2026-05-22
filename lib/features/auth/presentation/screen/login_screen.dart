import 'package:airman_toga/core/mock_data/auth_mock_data.dart';
import 'package:airman_toga/core/theme/app_colors.dart';
import 'package:airman_toga/features/auth/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flight,size: 30,color: AppColors.secondary,),
                const Text(
                  "TOGA",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textwhite),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            

            const Text("AI PILOT LEARNING & TRAINING",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textHint)),

            const SizedBox(height: 24),

            CadetProfileCard(
              profile: MockCadetProfile.profile,
              isLoading: authProvider.isLoading,
              onContinue: () async {
                await authProvider.login();

                if (!context.mounted) return;

                if (authProvider.currentUser != null) {
                  Navigator.pushReplacementNamed(context, "/dashboard");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(authProvider.error ?? "Login failed"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
