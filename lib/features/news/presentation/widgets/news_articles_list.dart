import 'package:flutter/material.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/core/widgets/custom_divider.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';
import 'package:news_app/features/news/presentation/widgets/article_item.dart';

class NewsArticlesList extends StatelessWidget {
  const NewsArticlesList({super.key, required this.articles, this.isSliver=true, this.scrollController});
  final List<ArticleModel> articles;
  final bool? isSliver;
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return isSliver==true? SliverList.separated(
      
        separatorBuilder: (context, index) => const CustomDivider(),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              child: ArticleItem(
                articleModel: articles[index],
              ),
            ),
        itemCount: articles.length) :ListView.separated(
          controller: scrollController,
        separatorBuilder: (context, index) => const CustomDivider(),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              child: ArticleItem(
                articleModel: articles[index],
              ),
            ),
        itemCount: articles.length) ;
  }
}
