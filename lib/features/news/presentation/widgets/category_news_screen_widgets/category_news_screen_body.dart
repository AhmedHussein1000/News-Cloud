import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/category_news_screen_widgets/category_news_articles_bloc_builder.dart';

class CategoryNewsScreenBody extends StatelessWidget {
  const CategoryNewsScreenBody({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(child: CategoryNewsArticlesBlocBuilder(category:category,)),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
