import 'package:news_app/core/helpers/assets.dart';
import 'package:news_app/core/network/api_constants.dart';
import 'package:news_app/features/news/data/models/category_model.dart';

List<CategoryModel> categoriesData = const [
  CategoryModel(image: Assets.imagesBusiness, name: ApiConstants.business),
  CategoryModel(image: Assets.imagesSports, name: ApiConstants.sports),
  CategoryModel(
      image: Assets.imagesEntertainment, name: ApiConstants.entertainment),
  CategoryModel(image: Assets.imagesTechnology, name: ApiConstants.technology),
  CategoryModel(image: Assets.imagesHealth, name: ApiConstants.health),
  CategoryModel(image: Assets.imagesScience, name: ApiConstants.science),
];
