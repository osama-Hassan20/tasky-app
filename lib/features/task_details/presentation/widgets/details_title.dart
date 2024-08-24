import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({
    super.key,
    this.isDate = false,
    required this.text,
    required this.iconData,
    this.isFlag = false,
  });

  final bool isDate;
  final bool isFlag;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF0ECFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isDate
                ? Text('End Date', style: AppStyles.styleRegular9(context))
                : const SizedBox(),
            Row(
              children: [
                isFlag
                    ? const Icon(
                        Icons.flag,
                        color: Color(0xff5F33E1),
                      )
                    : const SizedBox(),
                Text(text,
                    style: isDate
                        ? AppStyles.styleRegular14(context)
                            .copyWith(color: const Color(0xFF24252C))
                        : AppStyles.styleBold16(context).copyWith(
                            color: const Color(0xFF5F33E1),
                          )),
                const Spacer(),
                Icon(
                  iconData,
                  color: const Color(0xff5F33E1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
