import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/api_healper/end_point.dart';
import 'package:tasky/features/auth/presentation/manger/register_cubit/states.dart';

import '../../../../../core/utils/api_healper/dio_helper.dart';
import '../../../../../core/utils/local_service_helper/cache_helper.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;


  void changePasswordVisibility() {
    debugPrint('changePasswordVisibility');
    isPasswordShown = !isPasswordShown;
    suffix =
    isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> userRegister({
    required String username,
    required String password,
    required String phone,
    required int experienceYears,
    required String address,
    required String level ,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
      url: EndPoint.signUp,
      data:
      {
        "phone" : phone,
        "password" : password,
        "displayName" : username,
        "experienceYears" : experienceYears,
        "address" : address,
        "level" : level
      },
    ).then((value) async {
      await CacheHelper.saveData(
          key: 'TokenId', value: value.data['access_token']);
      await CacheHelper.saveData(
          key: 'RefreshTokenId', value: value.data['refresh_token']);
          await CacheHelper.saveData(
          key: '_id', value: value.data['_id']);
      emit(RegisterSuccessState(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(RegisterErrorState(onError.response!.data['message']));
      }
    });
  }
}
