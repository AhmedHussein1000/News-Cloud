import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenHeight, screenWidth;

  static init(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
  }
}
