import 'package:flutter/material.dart';
import 'package:tasky/core/utils/size_config.dart';

import '../utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.style,
      this.widget,
      required this.onPressed});

  final TextStyle? style;
  final String text;
  final Widget? widget;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF5F33E1),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: style ?? AppStyles.styleBold16(context),
            ),
            const SizedBox(
              width: 8,
            ),
            widget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
