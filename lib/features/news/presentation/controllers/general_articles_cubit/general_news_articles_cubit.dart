import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/api_constants.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/data/repositories/base_news_repo.dart';
part 'general_news_articles_state.dart';

class GeneralNewsArticlesCubit extends Cubit<GeneralNewsArticlesState> {
  final BaseNewsRepo baseNewsRepo;
  GeneralNewsArticlesCubit(this.baseNewsRepo)
      : super(GeneralNewsArticlesInitial());
  int _totalResultsCount = 0;
  int _totalArticlesCount = 0;
  int _totalPages = 1;

  getGeneralArticles({int pageNumber = 1}) async {
    if (pageNumber > _totalPages) {
      emit(const GeneralNewsArticlesNoMoreData(
          message: AppConstants.noMoreArticles));
      return;
    }

    emit(pageNumber == 1
        ? GeneralNewsArticlesLoading()
        : GeneralNewsArticlesPaginationLoading());

    final result = await baseNewsRepo.getGeneralTopHeadlinesNewsArticles(
        pageNumber: pageNumber);
    result.fold((failure) {
      emit(pageNumber == 1
          ? GeneralNewsArticlesFailure(message: failure.message)
          : GeneralNewsArticlesPaginationFailure(message: failure.message));
    }, (articlesModelResponse) {
      int newArticlesCount = articlesModelResponse.articles?.length ?? 0;
      _totalResultsCount = articlesModelResponse.totalResults ?? 0;
      _totalArticlesCount += newArticlesCount;
      _totalPages = (_totalResultsCount / ApiConstants.pageSize).ceil();
      log('newArticlesCount: $newArticlesCount  totalArticlesCount: $_totalArticlesCount , totalResultsCount: $_totalResultsCount');
      emit(GeneralNewsArticlesSuccess(
          generalArticles: articlesModelResponse.articles ?? []));
    });
  }
}
