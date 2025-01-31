import 'package:flutter/material.dart';
import 'package:news_app/core/themes/app_colors.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      focusColor: AppColors.lightBlue,
      hintStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(color: AppColors.lightBlue);
        }
        return const TextStyle(color: Colors.white54);
      }),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
            const BorderSide(color: Colors.white54), 
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.lightBlue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),
      labelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(color: AppColors.lightBlue);
        }
        return const TextStyle(color: Colors.white54);
      }),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return const TextStyle(color: AppColors.lightBlue);
        }
        return const TextStyle(color: Colors.white54);
      }),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.lightBlue;
        }
        return Colors.white54;
      }),
    ),
    );
