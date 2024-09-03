import 'package:flutter/material.dart';
import 'package:tasky/features/home/presentation/widgets/mytask_header.dart';
import '../../../../core/utils/size_config.dart';
import '../manager/home_cubit/cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.defaultSize! * 2.4,
        bottom: SizeConfig.defaultSize! * 1.6,
        left: SizeConfig.defaultSize! * 2.2,
      ),
      child: Column(
        children: [
          MyTasksHeader(
            cubit: cubit,
          ),
        ],
      ),
    );
  }
}
