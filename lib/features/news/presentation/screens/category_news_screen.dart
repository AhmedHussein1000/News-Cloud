import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/category_news_screen_widgets/category_news_screen_body.dart';


class CategoryNewsArticlesScreen extends StatelessWidget {
  const CategoryNewsArticlesScreen({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category news')),
      body:  SafeArea(child: CategoryNewsScreenBody(category: category,)),
    );
  }
}
