import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';

abstract class HiveHelper {
  static const String articlesBoxkey = 'articles_box';
  static const String metadataBoxKey = 'metadata_box';
  static const int _cacheDurationMs = 60 * 60 * 1000;

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
    await box.put(_articleKey(category, pageNumber), cacheData);
  }

  static String _articleKey(String category, int page) => '${category}_page_$page';
  static String _metadataKey(String category) => '${category}_metadata';

  static List<ArticleModel> getArticles(
      {required String category, required int pageNumber}) {
    final box = Hive.box<Map>(articlesBoxkey);
    final cachedData = box.get(_articleKey(category, pageNumber));
    if (cachedData == null) return [];
    
    final int timestamp = cachedData['timestamp'] as int;
    if (_isExpired(timestamp)) {
      box.delete(_articleKey(category, pageNumber));
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
    final metadata = {
      'totalResults': totalResults,
      'totalPages': totalPages,
      'timestamp': DateTime.now().millisecondsSinceEpoch, 
    };
    await box.put(_metadataKey(category), metadata);
  }

  static Map<String, int>? getCategoryMetadata({required String category}) {
    final box = Hive.box<Map>(metadataBoxKey);
    final metadata = box.get(_metadataKey(category));

    if (metadata == null) return null;
    
    final int timestamp = metadata['timestamp'] as int;
    if (_isExpired(timestamp)) {
      box.delete(_metadataKey(category));
      return null;
    }

    return (metadata)
        .map((key, value) => MapEntry(key.toString(), value as int));
  }

  static bool _isExpired(int timestamp) {
    return DateTime.now().millisecondsSinceEpoch - timestamp > _cacheDurationMs;
  }

  static Future<void> cleanExpiredCache() async {
    final articlesBox = Hive.box<Map>(articlesBoxkey);
    final metadataBox = Hive.box<Map>(metadataBoxKey);
    
    for (final key in articlesBox.keys) {
      final cachedData = articlesBox.get(key);
      if (cachedData != null && cachedData['timestamp'] != null) {
        if (_isExpired(cachedData['timestamp'] as int)) {
          await articlesBox.delete(key);
        }
      }
    }
    
    for (final key in metadataBox.keys) {
      final metadata = metadataBox.get(key);
      if (metadata != null && metadata['timestamp'] != null) {
        if (_isExpired(metadata['timestamp'] as int)) {
          await metadataBox.delete(key);
        }
      }
    }
  }
}
