import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

import '../../../../core/utils/size_config.dart';
import '../manager/home_cubit/cubit.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: SizeConfig.defaultSize! * 0.8,
        ),
        itemBuilder: (context, index) => CategoryCard(
          category: categories[index],
          index: index,
          cubit: cubit,
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.category,
      required this.index,
      required this.cubit});

  final String category;
  final int index;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        cubit.counter =0;
        log('${cubit.counter}');
        
        cubit.changeIndex(index);
        if (index == 0) {
          cubit.status = 'tasks';
          
        } else if (index == 1) {
          cubit.status = 'inprogress';
        } else if (index == 2) {
          cubit.status = 'waiting';
        } else if (index == 3) {
          cubit.status = 'finished';
        }
        cubit.getTasks();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          cubit.activeIndex == index
              ? const Color(0xff5F33E1)
              : const Color(0xffF0ECFF),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      child: Text(
        categories[index],
        style: cubit.activeIndex == index
            ? AppStyles.styleBold16(context)
            : AppStyles.styleRegular16(context).copyWith(
                color: const Color(0xff7C7C80),
              ),
      ),
    );
  }
}

final List<String> categories = ['All', 'Inpogress', 'Waiting', 'Finished'];
