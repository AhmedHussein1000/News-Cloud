import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/controllers/search_articles_cubit/search_article_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_list.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_loading_widget.dart';

class SearchedArticlesBlocBuilder extends StatelessWidget {
  const SearchedArticlesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchArticleCubit, SearchArticlesState>(
      builder: (context, state) {
        if (state is SearchArticlesSuccess) {
          return state.searchedArticles==[]? const SliverToBoxAdapter(child: Center(child: Text('No Articles found'))) : NewsArticlesList(articles: state.searchedArticles);
        } else if (state is SearchArticlesFailure) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        } else if (state is SearchArticlesLoading) {
          return const NewsArticlesLoadingWidget();
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
