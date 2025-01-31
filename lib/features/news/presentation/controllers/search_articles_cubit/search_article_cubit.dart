import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/data/repositories/base_news_repo.dart';
part 'search_article_state.dart';

class SearchArticleCubit extends Cubit<SearchArticlesState> {
  final BaseNewsRepo baseNewsRepo;
  SearchArticleCubit(this.baseNewsRepo) : super(SearchArticlesInitial());

  getSearchedArticles({required String query}) async {
    emit(SearchArticlesLoading());
    var result = await baseNewsRepo.getSearchedArticles(query: query);
    result.fold((failure) => emit(SearchArticlesFailure(message:  failure.message)),
        (articles) => emit(SearchArticlesSuccess( searchedArticles:articles)));
  }
  clearSearchedArticles(){
    emit(const SearchArticlesSuccess(searchedArticles: []));
  }
}
