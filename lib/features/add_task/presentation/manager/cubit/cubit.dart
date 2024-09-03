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

  //Image
  File? taskImage;

  ///data/user/0/com.example.tasky/cache/f0d40a68-c236-4719-9dc4-762b5a42bec6/1000406394.jpg
  ///File: '/data/user/0/com.example.tasky/cache/file_picker/1724302232730/IMG-20240822-WA0014.jpg
  ///File: '/data/user/0/com.example.tasky/cache/file_picker/1724302232730/IMG-20240822-WA0014.jpg
  ImagePicker picker = ImagePicker();

  /// test image
  File? imageFile;
  String path = '';
  Future<void> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(
      source: imageSource,
    );
    if (image != null) {
      imageFile = File(image.path);
      // List<int> imageBytes = imageFile!.readAsBytesSync();
      // final base64Image = base64Encode(imageBytes);
      // await uploadImage();
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

  // Future<void> uploadImageTest() async {
  //   path = '';
  //   emit(UploadImageLoadingState());

  //   final response = await homeRepositoryImpl.uploadImage(imageFile!);
  //   response.fold((error) => emit(UploadImageErrorState(error: error.error)),
  //       (image) {
  //     path = image;
  //     emit(UploadImageSuccessState());
  //   });
  // }

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
      //  isFormData: true,
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

  // Future<void> getTaskImage(ImageSource imageSource) async {
  //   final pickedFile = await picker.pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     taskImage = File(pickedFile.path);
  //     print('taskImage = $taskImage');
  //     emit(HomeTaskImagePickedSuccessState());
  //   } else {
  //     print('No image selected');
  //     emit(HomeTaskImagePickedErrorState(pickedFile.toString()));
  //   }
  // }

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
      // OpenFile.open(platformFile!.path);
      // fileToDisplay = File(platformFile!.path.toString());
      // taskImage = File(pickedFile!.files.first.path);
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
      // removeTaskImage();
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
    //_id: 66c82b33ed5aa194fac25618
    ///data/user/0/com.example.tasky/cache/file_picker/1724394273304/JPEG_20240823_092433_1956854947796240328.jpg
    ///user: 66c7ad12ed5aa194fac25383
    // print('id ==== $id');
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
