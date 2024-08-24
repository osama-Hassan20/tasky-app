import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.styleBold24(context),
    );
  }
}
