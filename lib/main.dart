import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/functions/initialize_app.dart';
import 'package:news_app/core/routing/app_router.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:news_app/core/themes/dark_theme.dart';
import 'package:news_app/core/themes/light_theme.dart';

void main() async {
  await initializeApp();
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: const NewsApp(),
  ));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.watch<ThemeCubit>().state,
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
