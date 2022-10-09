import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      backgroundColor: AppColors.white,
      dialogBackgroundColor: AppColors.white,
      disabledColor: AppColors.lightGrey,
      dividerColor: AppColors.lightGrey,
      errorColor: AppColors.expense,
      primaryColor: AppColors.primary,
      shadowColor: AppColors.darkGrey,
      toggleableActiveColor: AppColors.primary,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.white,
          onSecondary: AppColors.black,
          error: AppColors.expense,
          onError: AppColors.white,
          background: AppColors.white,
          onBackground: AppColors.black,
          surface: AppColors.white,
          onSurface: AppColors.black),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        unselectedItemColor: AppColors.lightGrey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _appButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: _appButtonStyle),
      textButtonTheme: TextButtonThemeData(style: _appButtonStyle),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.white,
      ),
      cardTheme: const CardTheme(
        color: AppColors.white,
        margin: EdgeInsets.all(16.0),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.black.withOpacity(0.6),
        actionTextColor: AppColors.primary,
        disabledActionTextColor: AppColors.lightGrey,
        contentTextStyle: const TextStyle(color: AppColors.white),
      ),
    );
  }
}

ButtonStyle _appButtonStyle = const ButtonStyle(
  padding: MaterialStatePropertyAll(EdgeInsets.all(16.0)),
  textStyle: MaterialStatePropertyAll(
    TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    ),
  ),
  elevation: MaterialStatePropertyAll(0),
);
