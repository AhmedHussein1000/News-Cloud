import 'package:news_app/features/news/data/models/articles_model/article_model.dart';

abstract class DummyData {
  static  ArticleModel articleModel = ArticleModel(
      title:
          'Trump Administration Halts Public Health Agencies’ Activities - Forbes',
      publishedAt: "2025-01-23T20:37:36Z",
      url:
          '',
      urlToImage:
          '');
 static  List<ArticleModel> articlesDummyData = List.generate(5, (index) => articleModel);
}
