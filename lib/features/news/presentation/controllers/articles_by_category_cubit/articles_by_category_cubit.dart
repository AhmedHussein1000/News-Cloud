import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/api_constants.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/data/repositories/base_news_repo.dart';

part 'articles_by_category_state.dart';

class ArticlesByCategoryCubit extends Cubit<ArticlesByCategoryState> {
  final BaseNewsRepo baseNewsRepo;
  ArticlesByCategoryCubit(this.baseNewsRepo)
      : super(ArticlesByCategoryInitial());
  int _totalResultsCount = 0;
  int _totalArticlesCount = 0;
  int _totalPages = 1;
  getArticlesByCategory({required String category, int pageNumber = 1}) async {
    if (pageNumber > _totalPages) {
      emit(const ArticlesByCategoryNoMoreData(
          message: AppConstants.noMoreArticles));
      return;
    }
    emit(pageNumber == 1
        ? ArticlesByCategoryLoading()
        : ArticlesByCategoryPaginationLoading());
    final result = await baseNewsRepo.getTopHeadlinesNewsArticlesByCategory(
        category: category, pageNumber: pageNumber);
    result.fold((failure) {
      emit(pageNumber == 1
          ? ArticlesByCategoryFailure(message: failure.message)
          : ArticlesByCategoryPaginationFailure(message: failure.message));
    }, (articlesResponseModel) {
      int newArticlesCount = articlesResponseModel.articles?.length ?? 0;
      _totalResultsCount = articlesResponseModel.totalResults ?? 0;
      _totalArticlesCount += newArticlesCount;
      _totalPages = (_totalResultsCount / ApiConstants.pageSize).ceil();
      log('newArticlesCount: $newArticlesCount  totalArticlesCount: $_totalArticlesCount , totalResultsCount: $_totalResultsCount, totalPages: $_totalPages');

      emit(ArticlesByCategorySuccess(
          articles: articlesResponseModel.articles ?? []));
    });
  }
}
