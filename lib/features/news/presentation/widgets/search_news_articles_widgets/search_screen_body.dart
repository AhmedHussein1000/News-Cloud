import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/custom_textfield.dart';
import 'package:news_app/features/news/presentation/controllers/search_articles_cubit/search_article_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/search_news_articles_widgets/searched_articles_bloc_builder.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  late final TextEditingController searchController;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      context.read<SearchArticleCubit>().getSearchedArticles(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  hintText: 'Search here',
                  controller: searchController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        context
                            .read<SearchArticleCubit>()
                            .clearSearchedArticles();
                      },
                      icon: const Icon(Icons.clear)),
                  onChanged: (value) {
                    searchController.text = value;
                    _onSearchChanged(searchController.text);
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          const SearchedArticlesBlocBuilder(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
