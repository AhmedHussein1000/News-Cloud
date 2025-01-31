
import 'package:flutter/material.dart';
import 'package:news_app/core/themes/app_colors.dart';

class CustomCircleLoading extends StatelessWidget {
  const CustomCircleLoading({
    super.key, this.indicatorColor,
  });
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    return  Center(child:  CircularProgressIndicator(
      color: indicatorColor ?? AppColors.lightBlue,
    ));
  }
}
