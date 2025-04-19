import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/custom_bloc_observer.dart';
import 'package:news_app/core/network/api_service.dart';
import 'package:news_app/core/cache/cache_helper.dart';
import 'package:news_app/core/cache/hive_helper.dart';
import 'package:news_app/core/di/service_locator.dart';
Future<void> initializeApp() async {
   WidgetsFlutterBinding.ensureInitialized();
  ApiService.initializeDio();
  await CacheHelper.init();
  setupServiceLocator();
   await HiveHelper.initHive();
  await HiveHelper.cleanExpiredCache();
  Bloc.observer = CustomBlocObserver();
}