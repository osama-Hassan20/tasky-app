import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/size_config.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection(
      {super.key, required this.title, required this.value, this.widget});

  final String title;
  final String value;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize! * 1.5,
          vertical: SizeConfig.defaultSize! * 1.2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.styleMedium12(context),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  value,
                  style: AppStyles.styleBold18(context),
                )
              ],
            ),
            SizedBox(child: widget),
          ],
        ),
      ),
    );
  }
}
