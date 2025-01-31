import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/helpers/assets.dart';
import 'package:news_app/core/helpers/extensions.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/themes/app_styles.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/news/data/models/articles_model/article_model.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.articleModel});
  final ArticleModel articleModel;

  _convertDate(String? date) {
    if (!date.isNullOrEmpty()) {
      DateTime parsedDate = DateTime.parse(date!);
      return DateFormat('yyyy-MM-dd HH:mm a').format(parsedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.pushNamed(Routes.articleWebView, arguments: articleModel.url),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: articleModel.urlToImage != null
                  ? CachedNetworkImage(
                      imageUrl: articleModel.urlToImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.asset(Assets.imagesBlueLoadingAnimation),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset(
                      Assets.imagesNews,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articleModel.title ?? AppConstants.unknownTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Styles.styleMedium16(context),
                ),
                const SizedBox(height: 5),
                Text(
                  _convertDate(articleModel.publishedAt) ??
                      AppConstants.unknownPublishDate,
                  style: Styles.styleRegular14(context)
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
