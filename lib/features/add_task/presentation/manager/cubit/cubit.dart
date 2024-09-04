import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  Future<void> pickImage({required ImageSource imageSource}) async {
    final ImagePicker picker = ImagePicker();

    ///data/user/0/com.example.tasky/cache/d0e42c30-a216-4af0-8620-3c89a3280bbc3745160777585045248.jpg
    ///data/user/0/com.example.tasky/cache/404855c9-4df4-41b8-863e-8f0ccb735f72/1000414582.jpg
    XFile? image =
        await picker.pickImage(source: imageSource, imageQuality: 50);
    if (image != null) {
      imageFile = File(image.path);
      int fileSizeInBytes = imageFile!.lengthSync();

      double fileSizeInKB = fileSizeInBytes / 1024;

      print('حجم الصورة: ${fileSizeInKB.toStringAsFixed(2)} KB');

      if (fileSizeInKB < 1024) {
        uploadImage();
      } else {
        // await compressAndUploadImage();
        uploadImage();
      }

      emit(PickImageSuccessState());
    }
  }

  Future<void> compressAndUploadImage() async {
    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile!.path,
      quality: 10,
    );

    final compressedFile = File('${imageFile!.path}_compressed.jpg');
    await compressedFile.writeAsBytes(compressedImage!);

    imageFile = compressedFile;
    uploadImage();
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
    print(imageFile!.path);
    log('message');
    DioHelper.postData(
      url: EndPoint.uploadImage,
      data: fromData,
    ).then((value) {
      path = value.data['image'];
      emit(UploadImageSuccess(value.data['image']));
    }).catchError((onError) {
      print('objectobjectobjectobjectobjectobject');
      // print(onError.message);
      // print(onError.response);
      print(onError.toString());
      emit(UploadImageError());
      // emit(RemoveTaskImageState());
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
