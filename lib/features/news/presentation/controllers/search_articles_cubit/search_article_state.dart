part of 'search_article_cubit.dart';

sealed class SearchArticlesState {
  const SearchArticlesState();
}

final class SearchArticlesInitial extends SearchArticlesState {}
final class SearchArticlesLoading extends SearchArticlesState {}

final class SearchArticlesSuccess extends SearchArticlesState {
  final List<ArticleModel> searchedArticles;
  const SearchArticlesSuccess({required this.searchedArticles});
}

final class SearchArticlesFailure extends SearchArticlesState {
  final String message;

  const SearchArticlesFailure({required this.message});
}

