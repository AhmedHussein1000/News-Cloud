part of 'articles_by_category_cubit.dart';

sealed class ArticlesByCategoryState {
  const ArticlesByCategoryState();
}

final class ArticlesByCategoryInitial extends ArticlesByCategoryState {}

final class ArticlesByCategoryLoading extends ArticlesByCategoryState {}

final class ArticlesByCategoryPaginationLoading
    extends ArticlesByCategoryState {}

final class ArticlesByCategorySuccess extends ArticlesByCategoryState {
  final List<ArticleModel> articles;
  const ArticlesByCategorySuccess({required this.articles});
}

final class ArticlesByCategoryFailure extends ArticlesByCategoryState {
  final String message;
  const ArticlesByCategoryFailure({required this.message});
}

final class ArticlesByCategoryPaginationFailure
    extends ArticlesByCategoryState {
  final String message;
  const ArticlesByCategoryPaginationFailure({required this.message});
}

final class ArticlesByCategoryNoMoreData extends ArticlesByCategoryState {
  final String message;

const  ArticlesByCategoryNoMoreData({required this.message});
}
