import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';

abstract class HiveHelper {
  static const String articlesBoxkey = 'articles_box';
  static const String metadataBoxKey = 'metadata_box';
  static Future<void> initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ArticleModelAdapter());
    }
    if (!Hive.isBoxOpen(articlesBoxkey)) {
      await Hive.openBox<Map>(articlesBoxkey);
    }
    if (!Hive.isBoxOpen(metadataBoxKey)) {
      await Hive.openBox<Map>(metadataBoxKey);
    }
  }

  static Future<void> saveArticles(
      {required String category,
      required int pageNumber,
      required List<ArticleModel> articles}) async {
    final box = Hive.box<Map>(articlesBoxkey);
    final cacheData = {
      'articles': articles,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    await box.put('${category}_page_$pageNumber', cacheData);
  }

  static List<ArticleModel> getArticles(
      {required String category, required int pageNumber}) {
    final box = Hive.box<Map>(articlesBoxkey);
    final cachedData = box.get('${category}_page_$pageNumber');
    if (cachedData == null) return [];
    final int timestamp = cachedData['timestamp'] as int;
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    const int oneHourInMilliSeconds = 60 * 60 * 1000;
    if (currentTimestamp - timestamp > oneHourInMilliSeconds) {
      box.delete('${category}_page_$pageNumber');
      return [];
    }
    return (cachedData['articles'] as List).cast<ArticleModel>();
  }

  static Future<void> saveCategoryMetadata({
    required String category,
    required int totalResults,
    required int totalPages,
  }) async {
    final box = Hive.box<Map>(metadataBoxKey);
    Map<String, int> metadata = {
      'totalResults': totalResults,
      'totalPages': totalPages
    };
    await box.put('${category}_metadata', metadata);
  }

  static Map<String, int>? getCategoryMetadata({required String category}) {
    final box = Hive.box<Map>(metadataBoxKey);
    final metadata = box.get('${category}_metadata');

    if (metadata == null) {
      return null;
    }

    return (metadata)
        .map((key, value) => MapEntry(key.toString(), value as int));
  }
}
