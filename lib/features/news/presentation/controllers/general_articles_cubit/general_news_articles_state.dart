part of 'general_news_articles_cubit.dart';

sealed class GeneralNewsArticlesState {
  const GeneralNewsArticlesState();
}

final class GeneralNewsArticlesInitial extends GeneralNewsArticlesState {}
final class GeneralNewsArticlesLoading extends GeneralNewsArticlesState {}

final class GeneralNewsArticlesPaginationLoading extends GeneralNewsArticlesState {}
final class GeneralNewsArticlesSuccess extends GeneralNewsArticlesState {
  final List<ArticleModel> generalArticles;

 const  GeneralNewsArticlesSuccess({required this.generalArticles});
}
final class GeneralNewsArticlesFailure extends GeneralNewsArticlesState {
  final String message;

const  GeneralNewsArticlesFailure({required this.message});
}
final class GeneralNewsArticlesPaginationFailure extends GeneralNewsArticlesState {
  final String message;

const  GeneralNewsArticlesPaginationFailure({required this.message});
}

final class GeneralNewsArticlesNoMoreData extends GeneralNewsArticlesState {
  final String message;

 const GeneralNewsArticlesNoMoreData({required this.message});
}
