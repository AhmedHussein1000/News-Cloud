import 'dart:developer';
import 'package:news_app/core/cache/hive_helper.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/network/api_constants.dart';
import 'package:news_app/core/network/api_error_model.dart';
import 'package:news_app/core/network/api_service.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/data/models/articles_model/articles_response_model.dart';
import 'package:news_app/core/helpers/extensions.dart';

abstract class BaseNewsRemoteDataSource {
  Future<ArticlesResponseModel> getTopHeadlinesNewsArticlesByCategory(
      {required String category, int pageNumber = 1});
  Future<List<ArticleModel>> getSearchedArticles({required String query});
}

class NewsRemoteDataSourceImpl implements BaseNewsRemoteDataSource {
  final ApiService apiService;

  const NewsRemoteDataSourceImpl(this.apiService);

  @override
  Future<ArticlesResponseModel> getTopHeadlinesNewsArticlesByCategory(
      {required String category, int pageNumber = 1}) async {
    final response = await apiService
        .getData(endPoint: ApiConstants.topHeadlines, queryParams: {
      'apiKey': ApiConstants.apiKey,
      'country': ApiConstants.usaCountryCode,
      'category': category,
      'pageSize': ApiConstants.pageSize,
      'page': pageNumber
    });
    if (response.data['status'] == 'ok') {
      ArticlesResponseModel articlesResponseModel =
          ArticlesResponseModel.fromJson(response.data);
      if (!articlesResponseModel.articles.isNullOrEmpty()) {
        await HiveHelper.saveArticles(
            category: category,
            pageNumber: pageNumber,
            articles: articlesResponseModel.articles!);
        int totalPages =
            ((articlesResponseModel.totalResults ?? 0) / ApiConstants.pageSize)
                .ceil();
        await HiveHelper.saveCategoryMetadata(
            category: category,
            totalResults: articlesResponseModel.totalResults ?? 0,
            totalPages: totalPages);
      }
      return articlesResponseModel;
    }
    ApiErrorModel apiErrorModel = ApiErrorModel.fromJson(response.data);
    log('error in getTopHeadlinesNewsArticles, code: ${apiErrorModel.code}, message: ${apiErrorModel.message}');
    throw ServerException(apiErrorModel.code.contains('apiKeyMissing')
        ? AppConstants.serverError
        : AppConstants.unexpectedError);
  }

  @override
  Future<List<ArticleModel>> getSearchedArticles(
      {required String query}) async {
    if (query.isEmpty) {
      return const [];
    } else {
      final response = await apiService.getData(
          endPoint: ApiConstants.everything,
          queryParams: {'apiKey': ApiConstants.apiKey, 'q': query});
      if (response.data['status'] == 'ok') {
        ArticlesResponseModel articlesResponseModel =
            ArticlesResponseModel.fromJson(response.data);
        List<ArticleModel>? articles = articlesResponseModel.articles;
        if (!articles.isNullOrEmpty()) {
          return articles!;
        } else {
          return const [];
        }
      }

      ApiErrorModel apiErrorModel = ApiErrorModel.fromJson(response.data);
      log('error in searchArticles, code: ${apiErrorModel.code}, message: ${apiErrorModel.message}');

      throw ServerException(apiErrorModel.code.contains('apiKeyMissing')
          ? AppConstants.serverError
          : AppConstants.unexpectedError);
    }
  }
}
