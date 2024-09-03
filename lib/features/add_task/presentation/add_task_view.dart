import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/size_config.dart';
import 'package:tasky/features/add_task/presentation/widgets/custom_title_tasks.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading_animation.dart';
import '../../../core/widgets/text_form_field.dart';
import 'manager/cubit/cubit.dart';
import 'manager/cubit/state.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priorityController = TextEditingController();

  final TextEditingController dueDateController = TextEditingController();

  String priority = '';

  String image = '';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priorityController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTaskCubit>(
      create: (context) => AddTaskCubit(),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          var cubit = AddTaskCubit.get(context);
          if (state is HomeTaskImagePickedSuccessState) {
            cubit.uploadImage(image: cubit.taskImage!);
          }
          if (state is AddTaskSuccess) {
            CherryToast.success(
              title: const Text('Added Successfully'),
              animationType: AnimationType.fromTop,
            ).show(context);
            // Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AddTaskCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                title: Text('Add new task',
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
                        // ignore: deprecated_member_use
                        color: Colors.black,
                      )),
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize! * 2.2),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(),
                      InkWell(
                        onTap: () async {
                          await cubit.pickImage(ImageSource.gallery);
                          // cubit.pickFile();
                        },
                        child: DottedBorder(
                          radius: const Radius.circular(10),
                          dashPattern: const [4, 4],
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          color: const Color(0xFF5F33E1),
                          child: cubit.imageFile != null
                              ? Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      height: 200.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: FileImage(cubit.imageFile!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cubit.removeTaskImage();
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
                              : SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        color: Color(0xFF5F33E1),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Add Img',
                                        textAlign: TextAlign.center,
                                        style: AppStyles.styleMedium19(context),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
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
                            return 'Date is required';
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
                        text: 'Due date',
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize! * 0.8,
                      ),
                      customTextFormField(
                        controller: dueDateController,
                        context: context,
                        type: TextInputType.datetime,
                        readOnly: true,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Date is required';
                          }
                          return null;
                        },
                        hintText: 'choose due date...',
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              ).then((onValue) {
                                setState(() {
                                  dueDateController.text =
                                      onValue.toString().split(' ')[0];
                                });
                              });
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF5F33E1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize! * 2.8,
                      ),
                      CustomButton(
                        text:
                            state is AddTaskLoading ? 'Loading...' : 'Add task',
                        widget: state is AddTaskLoading
                            ? const CustomLoadingAnimation(
                                color: Colors.white,
                              )
                            : const SizedBox(),
                        style: AppStyles.styleBold19(context),
                        onPressed: () {
                          if (cubit.imageFile != null) {
                            if (formKey.currentState!.validate()) {
                              cubit.addTask(
                                  title: titleController.text,
                                  desc: descriptionController.text,
                                  priority: priority,
                                  dueDate: dueDateController.text,
                                  context: context);
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
      ),
    );
  }
}
