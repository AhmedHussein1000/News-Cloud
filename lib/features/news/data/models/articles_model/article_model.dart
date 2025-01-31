import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? urlToImage;
  @HiveField(2)
  final String? publishedAt;
  @HiveField(3)
  final String? url;

  ArticleModel(
      {required this.title,
      required this.urlToImage,
      required this.publishedAt,
      required this.url});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
        url: json['url'] as String?,
      );
}
