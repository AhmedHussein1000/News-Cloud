import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/cache/hive_helper.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/data/data_sources/news_local_data_source.dart';
import 'package:news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/data/models/articles_model/articles_response_model.dart';
import 'package:news_app/features/news/data/repositories/base_news_repo.dart';

class NewsRepoImpl extends BaseNewsRepo {
  final BaseNewsRemoteDataSource baseNewsRemoteDataSource;
  final BaseNewsLocalDataSource baseNewsLocalDataSource;
  NewsRepoImpl(this.baseNewsRemoteDataSource, this.baseNewsLocalDataSource);
  @override
  Future<Either<Failure, ArticlesResponseModel>>
      getTopHeadlinesNewsArticlesByCategory(
          {required String category, int pageNumber = 1}) async {
    return await _getTopHeadlinesNewsByCategory(
        category: category, pageNumber: pageNumber);
  }

  @override
  Future<Either<Failure, ArticlesResponseModel>>
      getGeneralTopHeadlinesNewsArticles({int pageNumber = 1}) async {
    return await _getTopHeadlinesNewsByCategory(
        category: 'general', pageNumber: pageNumber);
  }

  Future<Either<Failure, ArticlesResponseModel>> _getTopHeadlinesNewsByCategory(
      {required String category, int pageNumber = 1}) async {
    try {
      List<ArticleModel> cachedArticles =
          baseNewsLocalDataSource.getCategoryCachedArticlesPerPage(
                  category: category, pageNumber: pageNumber)
              ;
      final categoryMetadata =
          HiveHelper.getCategoryMetadata(category: category);
      if (cachedArticles.isNotEmpty && categoryMetadata != null) {
        log('from cached ${cachedArticles.length}');
        return Right(ArticlesResponseModel(
            status: 'ok',
            totalResults: categoryMetadata['totalResults'],
            articles: cachedArticles));
      }

      ArticlesResponseModel articleResponseModel =
          await baseNewsRemoteDataSource.getTopHeadlinesNewsArticlesByCategory(
              category: category, pageNumber: pageNumber);
        log('from remote ${articleResponseModel.articles?.length}');      
      return Right(articleResponseModel);
    } on DioNetworkException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      log('error in getTopHeadlinesNewsArticles: ${e.toString()}');
      return const Left(ServerFailure(message: AppConstants.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> getSearchedArticles(
      {required String query}) async {
    try {
      List<ArticleModel> searchedArticles =
          await baseNewsRemoteDataSource.getSearchedArticles(query: query);

      return Right(searchedArticles);
    } on DioNetworkException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      log('error in searchArticles: ${e.toString()}');
      return const Left(ServerFailure(message: AppConstants.unexpectedError));
    }
  }
}
