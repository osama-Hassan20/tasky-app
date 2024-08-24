import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/core/utils/size_config.dart';

import '../../../profile/presentation/profile_view.dart';
import '../manager/home_cubit/cubit.dart';

class HomeViewAppbar extends StatelessWidget {
  const HomeViewAppbar({super.key, required this.cubit, });
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2.2),
        child: Row(
          children: [
            Text(
              'Logo',
              style: AppStyles.styleBold24(context),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                navigateTo(context, const ProfileView());
              },
              child: const Icon(Icons.account_circle_outlined),
            ),
            SizedBox(
              width: SizeConfig.defaultSize! * 2,
            ),
            InkWell(
              onTap: () {
                // singOut(context);
                print('logOut');
                cubit.logOut(context);
              },
              child: const Icon(
                Icons.logout_outlined,
                color: Color(0xff5F33E1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
