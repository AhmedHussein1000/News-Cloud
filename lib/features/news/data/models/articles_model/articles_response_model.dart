import 'package:news_app/features/news/data/models/articles_model/article_model.dart';

class ArticlesResponseModel {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  const ArticlesResponseModel( {required this.status,required this.totalResults, required this.articles});
  factory ArticlesResponseModel.fromJson(Map<String, dynamic> json) =>
      ArticlesResponseModel(
        status: json['status'] as String?,
        totalResults: json['totalResults'] as int?,
        articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
