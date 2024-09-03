import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/core/utils/size_config.dart';
import 'package:tasky/core/widgets/custom_cached_network_image.dart';
import 'package:tasky/features/home/presentation/widgets/status_task.dart';
import 'package:tasky/features/task_details/presentation/task_details_view.dart';
import '../../domain/models/tasks_model.dart';
import '../manager/home_cubit/cubit.dart';
import '../manager/home_cubit/state.dart';

import 'menu_pop_up.dart';
import 'package:path_provider/path_provider.dart';

class DefaultItem extends StatelessWidget {
  const DefaultItem({super.key, required this.taskModel});

  final TasksModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        var cubit = HomeCubit.get(context);
        if (state is DeleteTaskSuccessState) {
          CherryToast.success(
            title: const Text('Task Deleted Successfully'),
            animationType: AnimationType.fromTop,
          ).show(context);
          cubit.getTasks(page: 1);
        } else if (state is DeleteTaskErrorState) {
          CherryToast.error(
            title: Text(state.message),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Column(
          children: [
            InkWell(
              onTap: () {
                navigateTo(context, TaskDetailsView(taskModel: taskModel));
                print('object');
                print(Uri.file(
                  "/data/user/0/com.example.tasky/cache/file_picker/1724304315619/IMG-20240822-WA0014.jpg",
                ).toString());
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 60),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CustomCachedNetworkImage(
                            imageUrl: '${taskModel.image!}'),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.defaultSize! * 1.2,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(taskModel.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppStyles.styleBold16(context)
                                        .copyWith(
                                            color: const Color(0xff24252C))),
                              ),
                              StatusTask(taskModel: taskModel),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  taskModel.desc ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Color(0x9924252C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.flag_outlined,
                                    size: 16,
                                    color: taskModel.priority == 'low' ||
                                            taskModel.priority == 'Low'
                                        ? const Color(0xFF0087FF)
                                        : taskModel.priority == 'medium'
                                            ? const Color(0xFF5F33E1)
                                            : const Color(0xFFFF7D53),
                                  ),
                                  Text(taskModel.priority ?? '',
                                      style: AppStyles.styleMediumStatus12(
                                          taskModel.priority, context)),
                                ],
                              ),
                              Text(taskModel.createdAt!.split('T')[0],
                                  style: AppStyles.styleRegular12(context)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MenuPopUp(
                      cubit: cubit,
                      taskModel: taskModel,
                      delete: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<String> getImageUrl({required String url}) async {
  print('url = = = = = $url');
  final directory = await getTemporaryDirectory();
  final imagePath = '${directory.path}$url';
  final imageFile = File(imagePath);

  if (await imageFile.exists()) {
    return Uri.file(imagePath).toString();
  } else {
    return '';
  }
}
