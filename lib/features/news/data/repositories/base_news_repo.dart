import 'package:dartz/dartz.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/data/models/articles_model/articles_response_model.dart';

abstract class BaseNewsRepo {
  Future<Either<Failure, ArticlesResponseModel>>
      getGeneralTopHeadlinesNewsArticles({int pageNumber = 1});
  Future<Either<Failure, ArticlesResponseModel>>
      getTopHeadlinesNewsArticlesByCategory({required String category, int pageNumber = 1});
  Future<Either<Failure, List<ArticleModel>>> getSearchedArticles(
      {required String query});
}
