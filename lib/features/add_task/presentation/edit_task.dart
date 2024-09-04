import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/core/utils/size_config.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_cached_network_image.dart';
import 'package:tasky/core/widgets/custom_loading_animation.dart';
import 'package:tasky/core/widgets/text_form_field.dart';
import 'package:tasky/features/add_task/presentation/manager/cubit/cubit.dart';
import 'package:tasky/features/add_task/presentation/manager/cubit/state.dart';
import 'package:tasky/features/add_task/presentation/widgets/add_image_button.dart';
import 'package:tasky/features/add_task/presentation/widgets/custom_add_task_appbar.dart';
import 'package:tasky/features/add_task/presentation/widgets/custom_title_tasks.dart';
import 'package:tasky/features/home/domain/models/tasks_model.dart';
import 'package:tasky/features/home/presentation/home_view.dart';

// ignore: must_be_immutable
class EditTaskView extends StatefulWidget {
  EditTaskView({
    super.key,
    this.taskModel,
  });

  TasksModel? taskModel;

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priorityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  final TextEditingController dueDateController = TextEditingController();

  String priority = '';

  String image = '';
  @override
  void initState() {
    print(
        'priorityController.text = widget.taskModel!.priority!;   =  ${widget.taskModel!.priority!}');
    titleController.text = widget.taskModel!.title!;
    descriptionController.text = widget.taskModel!.desc!;
    priorityController.text = widget.taskModel!.priority!;
    dueDateController.text = widget.taskModel!.updatedAt!;
    statusController.text = widget.taskModel!.status!;
    priority = priorityController.text;
    AddTaskCubit.get(context).imageFile = File(widget.taskModel!.image!);
    image = widget.taskModel!.image!;

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priorityController.dispose();
    dueDateController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is EditTaskSuccess) {
          CherryToast.success(
            title: const Text('Edited Successfully'),
            animationType: AnimationType.fromTop,
          ).show(context);
          navigateAndFinish(context, HomeView());
        }
      },
      builder: (context, state) {
        var cubit = AddTaskCubit.get(context);

        return Scaffold(
          appBar: customAddTaskAppbar(context: context, title: 'Edit task'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize! * 2.2),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DottedBorder(
                      radius: const Radius.circular(10),
                      dashPattern: const [4, 4],
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      color: const Color(0xFF5F33E1),
                      child: cubit.imageFile != null
                          ? Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                image == ''
                                    ? Container(
                                        height: 200.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: FileImage(cubit.imageFile!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : ConstrainedBox(
                                        constraints: const BoxConstraints(
                                            maxHeight: 225),
                                        child: SizedBox(
                                            width: double.maxFinite,
                                            child: CustomCachedNetworkImage(
                                                imageUrl: image)),
                                      ),
                                IconButton(
                                  onPressed: () {
                                    cubit.removeTaskImage();
                                    image = '';
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.close,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : AddImageButton(cubit: cubit),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 1.6,
                    ),
                    const CustomTitleTasks(
                      text: 'Task title',
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 0.8,
                    ),
                    customTextFormField(
                      controller: titleController,
                      context: context,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'description is required';
                        }
                        return null;
                      },
                      hintText: 'Enter title here...',
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 1.6,
                    ),
                    const CustomTitleTasks(
                      text: 'Task Description',
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 0.8,
                    ),
                    customTextFormField(
                        controller: descriptionController,
                        context: context,
                        type: TextInputType.multiline,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'description is required';
                          }
                          return null;
                        },
                        hintText: 'Enter description here...',
                        maxLines: 7),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 1.6,
                    ),
                    const CustomTitleTasks(
                      text: 'Priority',
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 0.8,
                    ),
                    customTextFormField(
                      borderWidth: 0,
                      color: const Color(0xFFF0ECFF),
                      borderColor: Colors.transparent,
                      controller: priorityController,
                      context: context,
                      type: TextInputType.datetime,
                      readOnly: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Priority is required';
                        }
                        return null;
                      },
                      hintText: 'Priority',
                      prefix: Icons.flag,
                      hintStyle: AppStyles.styleBold16(context).copyWith(
                        color: const Color(0xff5F33E1),
                      ),
                      style: AppStyles.styleBold16(context).copyWith(
                        color: const Color(0xff5F33E1),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 100,
                          child: DropdownMenuItem(
                            alignment: Alignment.centerRight,
                            child: DropdownButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 32,
                                color: Color(0xff5F33E1),
                              ),
                              underline: const SizedBox(),
                              items: const [
                                DropdownMenuItem(
                                  value: 'medium',
                                  child: Text('Medium '),
                                ),
                                DropdownMenuItem(
                                  value: 'low',
                                  child: Text('Low '),
                                ),
                                DropdownMenuItem(
                                  value: 'high',
                                  child: Text('Heigh '),
                                ),
                              ],
                              onChanged: (value) {
                                priorityController.text =
                                    '${value.toString()} Priority';
                                priority = value.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 1.6,
                    ),
                    const CustomTitleTasks(
                      text: 'Status',
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 0.8,
                    ),
                    customTextFormField(
                      borderWidth: 0,
                      color: const Color(0xFFF0ECFF),
                      borderColor: Colors.transparent,
                      controller: statusController,
                      context: context,
                      type: TextInputType.datetime,
                      readOnly: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'status is required';
                        }
                        return null;
                      },
                      hintText: 'status',
                      hintStyle: AppStyles.styleBold16(context).copyWith(
                        color: const Color(0xff5F33E1),
                      ),
                      style: AppStyles.styleBold16(context).copyWith(
                        color: const Color(0xff5F33E1),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 120,
                          child: DropdownMenuItem(
                            alignment: Alignment.centerRight,
                            child: DropdownButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 32,
                                color: Color(0xff5F33E1),
                              ),
                              underline: const SizedBox(),
                              items: const [
                                DropdownMenuItem(
                                  value: 'waiting',
                                  child: Text('waiting '),
                                ),
                                DropdownMenuItem(
                                  value: 'inprogress',
                                  child: Text('inprogress '),
                                ),
                                DropdownMenuItem(
                                  value: 'finished',
                                  child: Text('finished '),
                                ),
                              ],
                              onChanged: (value) {
                                statusController.text = '${value.toString()}';
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize! * 2.8,
                    ),
                    CustomButton(
                      text:
                          state is EditTaskLoading ? 'Loading...' : 'Edit Task',
                      widget: state is EditTaskLoading
                          ? const CustomLoadingAnimation(
                              color: Colors.white,
                            )
                          : const SizedBox(),
                      style: AppStyles.styleBold19(context),
                      onPressed: () {
                        if (image != '' || cubit.path != '') {
                          if (formKey.currentState!.validate()) {
                            cubit.editTask(
                                image: image,
                                title: titleController.text,
                                desc: descriptionController.text,
                                priority: priority,
                                context: context,
                                status: statusController.text,
                                taskId: widget.taskModel!.id!);
                          }
                        } else {
                          CherryToast.success(
                            title: const Text('image is required'),
                            animationType: AnimationType.fromTop,
                          ).show(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
