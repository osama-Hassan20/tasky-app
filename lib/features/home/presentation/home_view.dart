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
              // if(cubit.isLoadUp)
              // Container(
              //   padding: const EdgeInsets.only(top: 30, bottom: 40),
              //   child: Center(
              //     child: CustomLoadingAnimation(color:Color(0xff5F33E1),)
              //   ),
              // ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.defaultSize! * 2.2,
                ),
                child: TasksListView(
                  cubit: cubit,
                ),
              )),
              if (cubit.tasksModel.length < 20)
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Center(
                    child: cubit.hasMore
                        ? CustomLoadingAnimation(
                            color: Color(0xff5F33E1),
                          )
                        : Text('no more task to load'),
                  ),
                ),
              //       if(true){
              //     Container(
              // padding: const EdgeInsets.only(top: 30, bottom: 40),
              // color: Colors.amber,
              // child: const Center(
              //   child: CustomLoadingAnimation(color: Colors.amber,)
              // )),

              //   }

              //           Expanded(
              //   child: ListView.separated(
              //     itemBuilder: (context, index) =>Container(
              //     height: 20,
              //     color: Colors.amber,
              //   ),
              //      separatorBuilder: (context, index) =>SizedBox(height: 5,),
              //       itemCount: 50
              //       ),
              // ),
            ],
          ),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: CustomScrollView(
          //     slivers: <Widget>[
          //       SliverAppBar(
          //         elevation: 0.0,
          //         pinned: true,
          //         title: HomeViewAppbar(
          //           cubit: cubit,
          //         ),
          //       ),
          //       SliverList(
          //         delegate: SliverChildListDelegate(
          //           [
          //             HomeViewBody(
          //               cubit: cubit,
          //             ),

          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          floatingActionButton: FloatingActionButtons(
            cubit: cubit,
          ),
        );
      },
    );
  }
}
