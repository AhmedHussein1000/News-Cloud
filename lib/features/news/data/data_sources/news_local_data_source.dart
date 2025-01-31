import 'package:news_app/core/cache/hive_helper.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';

abstract class BaseNewsLocalDataSource {
  List<ArticleModel> getCategoryCachedArticlesPerPage(
      {required String category, required int pageNumber});
}

class NewsLocalDataSourceImpl implements BaseNewsLocalDataSource {
  @override
  List<ArticleModel> getCategoryCachedArticlesPerPage(
      {required String category, required int pageNumber}) {
    return HiveHelper.getArticles(category: category, pageNumber: pageNumber);
  }
}
