import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes/app_styles.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/presentation/controllers/general_articles_cubit/general_news_articles_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/home_screen_widgets/general_news_articles_bloc_builder.dart';
import 'package:news_app/features/news/presentation/widgets/home_screen_widgets/news_categories.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  bool isLoading = false;
  int nextPage = 2;
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollerListener);
    super.initState();
  }

  _scrollerListener() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      if (!isLoading &&
          context.read<GeneralNewsArticlesCubit>().state
              is! GeneralNewsArticlesNoMoreData) {
        await _loadNextPage();
      }
    }
  }

  Future<void> _loadNextPage() async {
     setState(() {
      isLoading = true;
    });
    context
        .read<GeneralNewsArticlesCubit>()
        .getGeneralArticles(pageNumber: nextPage++);
           
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: AppConstants.defaultPadding),
                child: Text(
                  'Categories',
                  style: Styles.styleBold22(context),
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const NewsCategories(),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppConstants.defaultPadding, bottom: 10),
                child: Text(
                  'General News',
                  style: Styles.styleBold22(context),
                ),
              ),
            ],
          ),
        ),
        const GeneralNewsArticlesBlocBuilder(),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
      ],
    );
  }
}
