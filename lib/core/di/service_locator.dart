import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/api_service.dart';
import 'package:news_app/features/news/data/data_sources/news_local_data_source.dart';
import 'package:news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:news_app/features/news/data/repositories/base_news_repo.dart';
import 'package:news_app/features/news/data/repositories/news_repo_impl.dart';

final GetIt getIt = GetIt.instance;
void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<BaseNewsRepo>(
    () => NewsRepoImpl(getIt(),getIt()),
  );
  // data sources
  getIt.registerLazySingleton<BaseNewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(getIt()) ,);
    getIt.registerLazySingleton<BaseNewsLocalDataSource>(() => NewsLocalDataSourceImpl() ,);

  // Services
  getIt.registerLazySingleton(
    () => ApiService(),
  );
  
}
