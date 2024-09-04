import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/utils/app_styles.dart';

AppBar customAddTaskAppbar(
    {required BuildContext context, required String title}) {
  return AppBar(
      title: Text(title,
          style: AppStyles.styleBold16(context)
              .copyWith(color: const Color(0xFF24252C))),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Transform.rotate(
            angle: -1.57079633 * 2,
            child: SvgPicture.asset(
              ImageAssets.arrowIcon,
              // ignore: deprecated_member_use
              color: Colors.black,
            )),
      ));
}
