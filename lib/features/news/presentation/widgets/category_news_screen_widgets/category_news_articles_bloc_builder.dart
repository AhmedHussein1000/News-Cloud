import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/core/functions/show_toast.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/presentation/controllers/articles_by_category_cubit/articles_by_category_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_list.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_loading_widget.dart';

class CategoryNewsArticlesBlocBuilder extends StatefulWidget {
  const CategoryNewsArticlesBlocBuilder({super.key, required this.category});
  final String category;
  @override
  State<CategoryNewsArticlesBlocBuilder> createState() =>
      _CategoryNewsArticlesBlocBuilderState();
}

class _CategoryNewsArticlesBlocBuilderState
    extends State<CategoryNewsArticlesBlocBuilder> {
  bool isLoading = false;
  int nextPage = 2;
  late ScrollController _scrollController;
  List<ArticleModel> allArticles = [];
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollerListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollerListener() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (!isLoading &&
          context.read<ArticlesByCategoryCubit>().state
              is! ArticlesByCategoryNoMoreData) {
        _loadNextPage();
      }
    }
  }

  void _loadNextPage() async {
    setState(() {
      isLoading = true;
    });

    BlocProvider.of<ArticlesByCategoryCubit>(context).getArticlesByCategory(
        category: widget.category, pageNumber: nextPage++);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticlesByCategoryCubit, ArticlesByCategoryState>(
      listener: (context, state) {
        if (state is ArticlesByCategoryPaginationFailure) {
          customToast(message: state.message, state: ToastStates.error);
        }
        if (state is ArticlesByCategorySuccess) {
          allArticles.addAll(state.articles);
        }
        if (state is ArticlesByCategoryNoMoreData) {
          customToast(
              message: state.message,
              state: ToastStates.warning,
              toastLength: Toast.LENGTH_SHORT);
        }
      },
      builder: (context, state) {
        if (state is ArticlesByCategorySuccess ||
            state is ArticlesByCategoryPaginationFailure ||
            state is ArticlesByCategoryPaginationLoading ||
            state is ArticlesByCategoryNoMoreData) {
          return NewsArticlesList(
            articles: allArticles,
            isSliver: false,
            scrollController: _scrollController,
          );
        } else if (state is ArticlesByCategoryFailure) {
          return Center(child: Text(state.message));
        } else {
          return const NewsArticlesLoadingWidget(
            isSliver: false,
          );
        }
      },
    );
  }
}
