import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/api_healper/end_point.dart';
import 'package:tasky/core/utils/local_service_helper/constant.dart';
import 'package:tasky/features/add_task/presentation/manager/cubit/state.dart';
import 'package:tasky/features/home/presentation/manager/home_cubit/cubit.dart';
import '../../../../../core/utils/api_healper/dio_helper.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of(context);

  File? imageFile;
  String path = '';
  Future<void> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      imageFile = File(image.path);

      uploadImage();
      emit(PickImageSuccessState());
    }
  }

  Future<void> uploadImage() async {
    FormData fromData = FormData();
    fromData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
          contentType:
              DioMediaType.parse("image/${imageFile!.path.split('.').last}"),
        )));
    log('message');
    print(fromData.files);
    log('message');
    DioHelper.postData(
      url: EndPoint.uploadImage,
      data: fromData,
    ).then((value) {
      path = value.data['image'];
      emit(UploadImageSuccess(value.data['image']));
    }).catchError((onError) {
      if (onError is DioException) {
        print(onError.message);
        print(onError.response);
        print(onError.response!.data);
        emit(UploadImageError(onError.response!.data['message']));
      }
    });
  }

  void removeTaskImage() {
    imageFile = null;
    emit(RemoveTaskImageState());
  }

  Future<void> addTask({
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
    required BuildContext context,
  }) async {
    emit(AddTaskLoading());
    print('path = $path');
    print(path);
    await DioHelper.postData(
      url: EndPoint.tasks,
      data: {
        'title': title,
        'desc': desc,
        'priority': priority,
        'dueDate': dueDate,
        'image': path,
      },
    ).then((value) async {
      HomeCubit.get(context).getTasks(page: 1);

      emit(AddTaskSuccess());
    }).catchError((onError) {
      emit(AddTaskError());
    });
  }

  Future<void> editTask({
    required String title,
    required String desc,
    required String priority,
    required String taskId,
    required String status,
    required String image,
    required BuildContext context,
  }) async {
    print('taskId === $taskId');
    emit(EditTaskLoading());
    await DioHelper.putData(
      url: '${EndPoint.editTasks}/$taskId',
      data: {
        "status": status,
        "user": id,
        'title': title,
        'desc': desc,
        'priority': priority,
        'image': image == '' ? path : image,
      },
    ).then((value) async {
      HomeCubit.get(context).getTasks(page: 1);
      removeTaskImage();
      emit(EditTaskSuccess());
    }).catchError((onError) {
      emit(EditTaskError());
    });
  }
}
