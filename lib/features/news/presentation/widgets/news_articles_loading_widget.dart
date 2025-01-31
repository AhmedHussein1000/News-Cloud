import 'package:flutter/material.dart';
import 'package:news_app/core/utils/dummy_data.dart';
import 'package:news_app/features/news/presentation/widgets/news_articles_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsArticlesLoadingWidget extends StatelessWidget {
  const NewsArticlesLoadingWidget({super.key,  this.isSliver=true});
  final bool? isSliver;
  @override
  Widget build(BuildContext context) {
    return isSliver==true? Skeletonizer.sliver(
      enabled: true,
      child: NewsArticlesList(articles: DummyData.articlesDummyData),
    ) : Skeletonizer(
      enabled: true,
      child: NewsArticlesList(articles: DummyData.articlesDummyData,isSliver: false,),
    );
  }
}
