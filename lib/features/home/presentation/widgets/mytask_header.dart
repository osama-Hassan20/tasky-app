import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../manager/home_cubit/cubit.dart';
import 'categories_list.dart';

class MyTasksHeader extends StatelessWidget {
  const MyTasksHeader({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Tasks',
          style: AppStyles.styleBold16(context).copyWith(
            color: const Color(0xff24252C).withOpacity(0.6),
          ),
        ),
        SizedBox(
          height: SizeConfig.defaultSize! * 1.6,
        ),
        CategoriesListView(cubit: cubit),
      ],
    );
  }
}
