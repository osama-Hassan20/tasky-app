import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomTitleTasks extends StatelessWidget {
  const CustomTitleTasks({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.styleRegular12(context).copyWith(
        color: const Color(0xFF6E6A7C),
      ),
    );
  }
}
