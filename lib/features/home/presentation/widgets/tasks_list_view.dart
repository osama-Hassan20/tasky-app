import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/size_config.dart';
import 'package:tasky/core/widgets/custom_loading_animation.dart';
import 'package:tasky/features/auth/presentation/widgets/loading_page.dart';

import '../manager/home_cubit/cubit.dart';
import '../manager/home_cubit/state.dart';
import 'default_item.dart';

/*{

}*/
class TasksListView extends StatefulWidget {
  const TasksListView({super.key, required this.cubit});
  final HomeCubit cubit;
  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      widget.cubit.hasMore = true;
      widget.cubit.getTasks(page: 1);
    });
  }

  // bool isLoadMore =false;
  @override
  void initState() {
    super.initState();
    // widget.cubit.getTasks(page: 1);
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          widget.cubit.isLoadDown = true;
        });
        // page++;
        // await widget.cubit.getTasks(page: page);
        if (widget.cubit.hasMore == true) {
          page++;
          await widget.cubit.getTasks(page: page);
        }

        setState(() {
          widget.cubit.isLoadDown = false;
        });
      }
    });
    //     scrollController.addListener(()async{
    //   if(scrollController.position.pixels == scrollController.position.minScrollExtent){

    //     setState(() {
    //     widget.cubit.isLoadUp = true;
    //     });
    //     page = page -1;
    //     await widget.cubit.getTasks(page: page);
    //     setState(() {
    //       widget.cubit.isLoadUp = false;
    //     });
    //   }
    // });
    // scrollController.removeListener(
    //   ()async{
    //   if(scrollController.position.pixels == scrollController.position.minScrollExtent){

    //     setState(() {
    //       widget.cubit.isLoadMore = true;
    //     });
    //     page = page -1;
    //     await widget.cubit.getTasks(page: page);
    //     setState(() {
    //       widget.cubit.isLoadMore = false;
    //     });
    //   }
    // }
    // );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        print(cubit.tasksModel.length);

        return RefreshIndicator(
            onRefresh: _onRefresh,
            child: state is TasksLoadingState
                ? ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) => const NewsCardSkelton(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  )
                : cubit.tasksModel.isNotEmpty
                    ? ListView.builder(
                        controller: scrollController,
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        // itemCount: cubit.tasksModel.length,
                        itemCount: cubit.tasksModel.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          log('${cubit.counter}');
                          if (index >= cubit.tasksModel.length) {
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 40),
                                color: Colors.amber,
                                child: const Center(
                                    child: CustomLoadingAnimation(
                                  color: Colors.amber,
                                )));
                          } else {
                            print(
                                'ubit.tasksModel[index].status = ${cubit.tasksModel[index].status} == cubit.status = ${cubit.status}');
                            if (cubit.status == 'tasks') {
                              return DefaultItem(
                                taskModel: cubit.tasksModel[index],
                              );
                            } else if (cubit.tasksModel[index].status ==
                                cubit.status) {
                              cubit.counter++;
                              log('cubit.tasksModel[index].status == cubit.status');
                              log(cubit.tasksModel[index].status!);
                              log(cubit.status);
                              return DefaultItem(
                                taskModel: cubit.tasksModel[index],
                              );
                            } else {
                              return cubit.counter == 0 &&
                                      index == cubit.tasksModel.length - 1
                                  ? emptyWidget(cubit: cubit)
                                  : SizedBox();
                            }
                          }
                          return null;
                        },
                      )
                    : emptyWidget(cubit: cubit));
      },
    );
  }
}

class emptyWidget extends StatelessWidget {
  const emptyWidget({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight! / 3.5,
        ),
        Text(
          '${cubit.status} is empty',
          style: AppStyles.styleMedium19(context),
        ),
      ],
    );
  }
}
// for (int index = 0; index < widget.cubit.tasksModel.length; index++) {
//                             if (widget.cubit.tasksModel[index].status == cubit.status) {}
//                               navigateTo(context, TaskDetailsView(taskModel: widget.cubit.tasksModel[index]));
//                             }
//                           }
