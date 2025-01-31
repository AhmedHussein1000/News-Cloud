import 'package:flutter/material.dart';
import 'package:news_app/core/themes/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.hintText,
      this.keyboardType,
      required this.controller,
       this.labelText,
      this.suffixIcon, this.onChanged});
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? labelText;
  final IconButton? suffixIcon;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: AppColors.skyBlue,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ));
  }
}
