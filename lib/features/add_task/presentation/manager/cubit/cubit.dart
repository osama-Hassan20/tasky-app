import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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

  File? taskImage;

  ImagePicker picker = ImagePicker();

  File? imageFile;
  String path = '';
  Future<void> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(
      source: imageSource,
    );
    if (image != null) {
      imageFile = File(image.path);

      uploadImageTest();
      emit(PickImageSuccessState());
    }
  }

  Future<void> getPostImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      taskImage = File(pickedFile.path);
      print(taskImage.toString());
      emit(HomeTaskImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomeTaskImagePickedErrorState(pickedFile.toString()));
    }
  }

  Future<void> uploadImageTest() async {
    FormData fromData = FormData();
    fromData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
          contentType:
              DioMediaType.parse("image/${imageFile!.path.split('.').last}"),
        )));
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

  PlatformFile? platformFile;

  File? fileToDisplay;

  String? fileName;

  Future<void> pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (pickedFile != null) {
      fileName = pickedFile.files.first.name;
      platformFile = pickedFile.files.first;
      taskImage = File(platformFile!.path!);
      print('taskImage = $taskImage');

      uploadImage(image: taskImage!);
      emit(HomeTaskImagePickedSuccessState());
    } else {
      emit(HomeTaskImagePickedErrorState(pickedFile.toString()));
    }
  }

  void removeTaskImage() {
    taskImage = null;
    emit(RemoveTaskImageState());
  }

  Future<void> uploadImage({
    required File image,
  }) async {
    print('image.path = ${image.path}');
    print('image.path = ${image}');
    emit(UploadImageLoading());
    print(image);
    print('image.path = ${image.path}');
    print('image.path = ${image}');
    await DioHelper.postData(
        url: EndPoint.uploadImage,
        isFormData: true,
        data: {
          'image': image,
        }).then((value) {
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
    required File? image,
    required BuildContext context,
  }) async {
    print('taskImage!.path ${taskImage!.path}');
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
        'image': image!.path,
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
