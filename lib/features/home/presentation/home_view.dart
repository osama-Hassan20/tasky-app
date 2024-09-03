import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/size_config.dart';
import 'package:tasky/core/widgets/custom_loading_animation.dart';
import 'package:tasky/features/home/presentation/widgets/floating_action_buttons.dart';
import 'package:tasky/features/home/presentation/widgets/home_view_appbar.dart';
import 'package:tasky/features/home/presentation/widgets/home_view_body.dart';
import 'package:tasky/features/home/presentation/widgets/tasks_list_view.dart';

import 'manager/home_cubit/cubit.dart';
import 'manager/home_cubit/state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          CherryToast.success(
            title: const Text('LogOut Successfuly'),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              HomeViewAppbar(
                cubit: cubit,
              ),
              HomeViewBody(
                cubit: cubit,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.defaultSize! * 2.2,
                  ),
                  child: TasksListView(
                    cubit: cubit,
                  ),
                ),
              ),
              if (cubit.isLoadDown)
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Center(
                      child: CustomLoadingAnimation(
                    color: Color(0xff5F33E1),
                  )),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButtons(
            cubit: cubit,
          ),
        );
      },
    );
  }
}
