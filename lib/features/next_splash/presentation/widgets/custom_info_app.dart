import 'package:flutter/material.dart';
import 'package:tasky/core/utils/size_config.dart';

import '../../../../core/utils/app_styles.dart';

class CustomInfoApp extends StatelessWidget {
  const CustomInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.defaultSize! * 2.45,
        ),
        Text(
          'Task Management & \nTo-Do List',
          style: AppStyles.styleBold24(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: SizeConfig.defaultSize! * 1.6,
        ),
        Text(
          'This productive tool is designed to help \nyou better manage your task \nproject-wise conveniently!',
          style: AppStyles.styleRegular14(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: SizeConfig.defaultSize! * 3.25,
        ),
      ],
    );
  }
}
