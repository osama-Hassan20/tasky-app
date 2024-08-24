import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

Widget defaultTextButton({
  required GestureTapCallback? function,
  required String text,
  required BuildContext context,
  Color? textColor,
}) =>
    InkWell(
      onTap: function,
      child: Text(
        text,
        style: AppStyles.styleBol14(context),
      ),
    );
