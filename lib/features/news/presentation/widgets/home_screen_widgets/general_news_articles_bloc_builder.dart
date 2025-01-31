import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/functions/show_toast.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/presentation/controllers/general_articles_cubit/general_news_articles_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_list.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_loading_widget.dart';

class GeneralNewsArticlesBlocBuilder extends StatefulWidget {
  const GeneralNewsArticlesBlocBuilder({
    super.key,
  });

  @override
  State<GeneralNewsArticlesBlocBuilder> createState() =>
      _GeneralNewsArticlesBlocBuilderState();
}

class _GeneralNewsArticlesBlocBuilderState
    extends State<GeneralNewsArticlesBlocBuilder> {
  List<ArticleModel> allArticles = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralNewsArticlesCubit, GeneralNewsArticlesState>(
      listener: (context, state) {
        if (state is GeneralNewsArticlesPaginationFailure) {
          customToast(message: state.message, state: ToastStates.error);
        }
        if (state is GeneralNewsArticlesSuccess) {
          allArticles.addAll(state.generalArticles);
        }
        if (state is GeneralNewsArticlesNoMoreData) {
          customToast(message: state.message, state: ToastStates.warning);
        }
      },
      builder: (context, state) {
        if (state is GeneralNewsArticlesSuccess ||
            state is GeneralNewsArticlesPaginationFailure ||
            state is GeneralNewsArticlesPaginationLoading ||
            state is GeneralNewsArticlesNoMoreData) {
          return NewsArticlesList(articles: allArticles);
        } else if (state is GeneralNewsArticlesFailure) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        } else {
          return const NewsArticlesLoadingWidget();
        }
      },
    );
  }
}
