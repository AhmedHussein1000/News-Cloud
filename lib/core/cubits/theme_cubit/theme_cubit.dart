import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/cache/cache_helper.dart';
import 'package:news_app/core/cache/cache_keys.dart';
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getInitialTheme());

  static ThemeMode _getInitialTheme() {
    final bool isDark = CacheHelper.getData(CacheKeys.isDark)  ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final ThemeMode newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newTheme);
    CacheHelper.saveData(
      key: CacheKeys.isDark,
      value: newTheme == ThemeMode.dark,
    );
  }
}

