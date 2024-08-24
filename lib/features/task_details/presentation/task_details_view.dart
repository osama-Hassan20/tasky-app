import 'dart:io';

import 'package:cherry_toast/resources/arrays.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/utils/size_config.dart';
import 'package:tasky/core/widgets/custom_cached_network_image.dart';
import 'package:tasky/features/home/presentation/widgets/menu_pop_up.dart';
import 'package:tasky/features/task_details/presentation/widgets/details_title.dart';

import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_styles.dart';
import '../../home/domain/models/tasks_model.dart';
import '../../home/presentation/manager/home_cubit/cubit.dart';
import '../../home/presentation/manager/home_cubit/state.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.taskModel});

  final TasksModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        var cubit = HomeCubit.get(context);
        if(state is DeleteTaskSuccessState){
          CherryToast.success(
            title: const Text('Task Deleted Successfully'),
            animationType: AnimationType.fromTop,
          ).show(context);
          Navigator.pop(context);
          
            cubit.getTasks();
        
        } else if(state is DeleteTaskErrorState){
          CherryToast.error(
            title: Text(state.message),
            animationType: AnimationType.fromTop,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Task Details',
                style: AppStyles.styleBold16(context)
                    .copyWith(color: const Color(0xFF24252C))),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Transform.rotate(
                  angle: -1.57079633 * 2,
                  child: SvgPicture.asset(
                    ImageAssets.arrowIcon,
                    color: Colors.black,
                  )),
            ),
            actions: [
              MenuPopUp(cubit: cubit, taskModel: taskModel,delete:true,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.file(File(taskModel.image!)),
                  // Image.asset(ImageAssets.authHeaderImage),
                  // ConstrainedBox(
                    // constraints: const BoxConstraints(maxHeight: 225),
                    // child: SizedBox(
                        // width: double.maxFinite,
                        // child: CustomCachedNetworkImage(imageUrl: 'https://todo.iraqsapp.com/images/${taskModel.image!}')),
                  // ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 1.6,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        taskModel.title ?? '',
                        style: AppStyles.styleBold24(context)
                      ),

                      Text(
                        taskModel.desc ?? '',
                        style: AppStyles.styleRegular14(context).copyWith(color: Color(0x9924252C))
                      ),

                       SizedBox(
                        height: SizeConfig.defaultSize! * 1.6,
                      ),
                      DetailsTitle(text: taskModel.createdAt!.split('T')[0], iconData: Icons.calendar_month,isDate: true,),
                      SizedBox(
                        height: SizeConfig.defaultSize! * 1.6,
                      ),
                      DetailsTitle(text: taskModel.status ?? '', iconData: Icons.arrow_drop_down_rounded,),
                      SizedBox(
                        height: SizeConfig.defaultSize! * 1.6,
                      ),
                      DetailsTitle(isFlag:true ,text: taskModel.priority ?? '', iconData: Icons.arrow_drop_down_rounded,),

                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: QrImageView(
                          data: taskModel.id ?? '',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
