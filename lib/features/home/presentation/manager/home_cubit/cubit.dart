import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/api_healper/end_point.dart';
import 'package:tasky/features/home/presentation/manager/function.dart';
import 'package:tasky/features/home/presentation/manager/home_cubit/state.dart';

import '../../../../../core/utils/api_healper/dio_helper.dart';
import '../../../../../core/utils/local_service_helper/cache_helper.dart';
import '../../../../../core/utils/local_service_helper/constant.dart';
import '../../../domain/models/tasks_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> logOut(BuildContext context) async {
    emit(LoadingLogoutSate());
    token = CacheHelper.getData(key: 'TokenId');
    if (kDebugMode) {
      print(token);
    }
    await DioHelper.postData(
      url: EndPoint.logout,
      data: {"token": token},
    ).then((value) {
      emit(LogoutSuccessState());
      singOut(context);
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(LogoutErrorState(onError.response!.data['message']));
      }
    });
  }

  int activeIndex = 0;
  int counter=0;

  void changeIndex(int index) {
    activeIndex = index;
    emit(ChangeIndexState());
  }

  List<TasksModel> tasksModel = [];


String status ='tasks' ;

  Future<void> getTasks({int? page}) async {
    emit(TasksLoadingState());
    await DioHelper.getDate(
      url: EndPoint.tasks,
      query: {'page':page ?? 1},
    ).then((value) {
      tasksModel =
          (value.data as List).map((e) => TasksModel.fromJson(e)).toList();
      emit(TasksSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(TasksErrorState(onError.response!.data['message']));
      }
    });
  }

  Future<void> deleteTask({
    required String taskId,
  }) async {
    emit(DeleteTaskLoadingState());
    await DioHelper.deleteData(
      url: '${EndPoint.tasks}/$taskId',
    ).then((value) {
      print(activeIndex);
      emit(DeleteTaskSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(DeleteTaskErrorState(onError.response!.data['message']));
      }
    });
  }
 bool isLoadDown =false; 
 bool isLoadUp = false;
}
