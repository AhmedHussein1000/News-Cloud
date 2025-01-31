import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/widgets/no_route_defined_screen.dart';
import 'package:news_app/features/news/presentation/controllers/articles_by_category_cubit/articles_by_category_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/general_articles_cubit/general_news_articles_cubit.dart';
import 'package:news_app/features/news/presentation/controllers/search_articles_cubit/search_article_cubit.dart';
import 'package:news_app/features/news/presentation/screens/article_webview.dart';
import 'package:news_app/features/news/presentation/screens/category_news_screen.dart';
import 'package:news_app/features/news/presentation/screens/home_screen.dart';
import 'package:news_app/features/news/presentation/screens/search_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                GeneralNewsArticlesCubit(getIt())..getGeneralArticles(),
            child: const HomeScreen(),
          ),
        );
      case Routes.categoryNews:
        String category = arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ArticlesByCategoryCubit(getIt())..getArticlesByCategory(category: category),
            child: CategoryNewsArticlesScreen(
              category: category,
            ),
          ),
        );
      case Routes.articleWebView:
        String url = arguments as String;
        return MaterialPageRoute(
          builder: (_) => ArticleWebView(url: url),
        );
      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SearchArticleCubit(getIt()),
            child: const SearchScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NoRouteDefinedScreen());
    }
  }
}
