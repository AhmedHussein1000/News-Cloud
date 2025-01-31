import 'package:flutter/material.dart';
import 'package:news_app/core/helpers/extensions.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/themes/app_styles.dart';
import 'package:news_app/features/news/data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.categoryNews, arguments: categoryModel.name);
      },
      child: Stack(children: [
        Container(
          height: 85,
          width: 85 * 1.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(categoryModel.image), fit: BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 85,
          width: 85 * 1.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
          ),
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            categoryModel.name,
            style: Styles.styleBold22(context).copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
