import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cache/cache_helper.dart';
import 'package:news_app/core/cache/hive_helper.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/network/api_service.dart';
import 'package:news_app/core/routing/app_router.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:news_app/core/themes/dark_theme.dart';
import 'package:news_app/core/themes/light_theme.dart';
import 'package:news_app/custom_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.initializeDio();
  await CacheHelper.init();
  setupServiceLocator();
 await HiveHelper.initHive();
  Bloc.observer = CustomBlocObserver();
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
