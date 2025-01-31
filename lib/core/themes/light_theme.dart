import 'package:flutter/material.dart';
import 'package:news_app/core/themes/app_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black,
    ),
  ),
  // inputDecorationTheme
  inputDecorationTheme: InputDecorationTheme(
    
    focusColor: AppColors.skyBlue,
    hintStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return const TextStyle(color: AppColors.skyBlue);
      }
      return const TextStyle(color: Colors.black54);
    }),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide:
          const BorderSide(color: Colors.black54),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: AppColors.skyBlue),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.red),
    ),
    labelStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return const TextStyle(color: AppColors.skyBlue);
      }
      return const TextStyle(color: Colors.black54);
    }),
    floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return const TextStyle(color: AppColors.skyBlue);
      }
      return const TextStyle(color: Colors.black54);
    }),
    suffixIconColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return AppColors.skyBlue;
      }
      return Colors.black54;
    }),
  ),
);
