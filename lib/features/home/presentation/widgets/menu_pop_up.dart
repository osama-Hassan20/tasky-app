import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/features/add_task/presentation/edit_task.dart';
import 'package:tasky/features/add_task/presentation/manager/cubit/cubit.dart';

import '../../../../core/utils/app_styles.dart';
import '../../domain/models/tasks_model.dart';
import '../manager/home_cubit/cubit.dart';

class MenuPopUp extends StatelessWidget {
  const MenuPopUp({
    super.key,
    required this.cubit,
    required this.taskModel, required this.delete, 
  });

  final HomeCubit cubit;
  final TasksModel taskModel;
  final bool delete;

  @override
  Widget build(BuildContext context) {
    var taskCubit = AddTaskCubit.get(context);
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert,),
      color: Colors.white,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
              onTap: () {
                
                delete ? navigateTo(context, EditTaskView(taskModel: taskModel,)): taskModel.status =='waiting' ? taskCubit.editTask(
                  image: File(taskModel.image!),
                    title: taskModel.title!,
                     desc: taskModel.desc!,
                      priority: taskModel.priority!,
                       taskId: taskModel.id!,
                        status: 'finished',
                         context: context
                         ):taskCubit.editTask(
                          image: File(taskModel.image!),
                    title: taskModel.title!,
                     desc: taskModel.desc!,
                      priority: taskModel.priority!,
                       taskId: taskModel.id!,
                        status: 'waiting',
                         context: context
                         );
              },
              value: delete ? 'edit':taskModel.status =='waiting' ? 'finished' :'waiting',
              child: Opacity(
                opacity: 0.87,
                child: Text(delete ? 'Edit':taskModel.status =='waiting' ?'Finished' :'Waiting',
                    style:
                    delete ?  AppStyles.styleMedium16(context) : taskModel.status =='waiting' ? AppStyles.styleMedium16(context).copyWith(color: Color(0xff0087FF)): AppStyles.styleMedium16(context).copyWith(color: Color(0xffFF7D53))
                ),
              )),
          PopupMenuItem<String>(
            value: delete ? 'delete' : taskModel.status =='waiting' || taskModel.status =='finished'? 'inprogress' : 'finished',
            child: Opacity(
              opacity: 0.87,
              child: Text(
                delete ?  'Delete': taskModel.status =='waiting'|| taskModel.status =='finished' ? 'Inprogress' : 'finished',
                textAlign: TextAlign.right,
                style: 
                 delete ?  
                 AppStyles.styleMedium16(context).copyWith(color: Color(0xFFFF7D53)) : taskModel.status =='waiting' || taskModel.status =='finished'? AppStyles.styleMedium16(context)
                    .copyWith(
                  color: const Color(0xFF5F33E1),
                ) : AppStyles.styleMedium16(context).copyWith(color: Color(0xff0087FF)),
              ),
            ),
            onTap: () {
              delete ? cubit.deleteTask(
                  taskId: taskModel.id ?? '') : taskModel.status =='waiting' || taskModel.status =='finished'? taskCubit.editTask(
                    image: File(taskModel.image!),
                    title: taskModel.title!,
                     desc: taskModel.desc!,
                      priority: taskModel.priority!,
                       taskId: taskModel.id!,
                        status: 'inprogress',
                         context: context
                         ):taskCubit.editTask(
                    title: taskModel.title!,
                     desc: taskModel.desc!,
                      priority: taskModel.priority!,
                      image: File(taskModel.image!),
                       taskId: taskModel.id!,
                        status: 'finished',
                         context: context
                         );
            },
          ),
        ];
      },
    );
  }
}
