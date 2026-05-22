import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor:
        AppColors.primarybackground,

    colorScheme: const ColorScheme(

      brightness: Brightness.light,

      primary: AppColors.primary,
      secondary: AppColors.secondary,

      surface: AppColors.surface,

      error: AppColors.error,

      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
    ),

    appBarTheme: const AppBarTheme(

      backgroundColor:
          AppColors.primary,

      foregroundColor:
          Colors.white,

      elevation: 0,

      centerTitle: false,
    ),

    // cardTheme: CardTheme(

    //   color: AppColors.card,

    //   elevation: 2,

    //   shape: RoundedRectangleBorder(
    //     borderRadius:
    //         BorderRadius.circular(16),
    //   ),

    //   margin: EdgeInsets.zero,
    // ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

        minimumSize:
            const Size(
              double.infinity,
              52,
            ),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
      ),
    ),

    inputDecorationTheme:
        InputDecorationTheme(

      filled: true,

      fillColor:
          AppColors.surface,

      hintStyle: const TextStyle(
        color:
            AppColors.textHint,
      ),

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          12,
        ),

        borderSide:
            const BorderSide(
          color: Colors.transparent,
        ),
      ),

      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          12,
        ),

        borderSide:
            BorderSide(
          color:
              Colors.grey.shade300,
        ),
      ),

      focusedBorder:
          const OutlineInputBorder(

        borderRadius:
            BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),

        borderSide:
            BorderSide(
          color:
              AppColors.primary,
          width: 1.5,
        ),
      ),
    ),

    textTheme: const TextTheme(

      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight:
            FontWeight.bold,
        color:
            AppColors.textPrimary,
      ),

      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight:
            FontWeight.w600,
        color:
            AppColors.textPrimary,
      ),

      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight:
            FontWeight.w600,
        color:
            AppColors.textPrimary,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        color:
            AppColors.textPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color:
            AppColors.textSecondary,
      ),

      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight:
            FontWeight.w600,
      ),
    ),

    dividerColor:
        Colors.grey.shade300,

    progressIndicatorTheme:
        const ProgressIndicatorThemeData(
      color:
          AppColors.secondary,
    ),
  );


  static ThemeData darkTheme = ThemeData.dark().copyWith(

    useMaterial3: true,

    scaffoldBackgroundColor:
        const Color(0xFF121212),

    colorScheme:
        const ColorScheme.dark(

      primary:
          AppColors.secondary,

      secondary:
          AppColors.primary,
    ),

    // cardTheme: CardTheme(

    //   color:
    //       const Color(
    //           0xFF1E1E1E),

    //   shape:
    //       RoundedRectangleBorder(
    //     borderRadius:
    //         BorderRadius.circular(
    //       16,
    //     ),
    //   ),
    // ),
  );
}