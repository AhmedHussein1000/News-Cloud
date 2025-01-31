import 'package:flutter/material.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/data/static_data/categories_data.dart';
import 'package:news_app/features/news/presentation/widgets/home_screen_widgets/category_item.dart';

class NewsCategories extends StatelessWidget {
  const NewsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        separatorBuilder: (context, index) => const SizedBox(width: AppConstants.defaultPadding),
        scrollDirection: Axis.horizontal,
        itemCount: categoriesData.length,
        itemBuilder: (context, index) =>
            CategoryItem(categoryModel: categoriesData[index]),
      ),
    );
  }
}
