
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/auth/presentation/manger/login_cubit/states.dart';

import '../../../../../core/utils/api_healper/end_point.dart';
import '../../../../../core/utils/api_healper/dio_helper.dart';
import '../../../../../core/utils/local_service_helper/cache_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;


  void changePasswordVisibility() {
    debugPrint('changePasswordVisibility');
    isPasswordShown = !isPasswordShown;
    suffix =
    isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> userLogin({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
      url: EndPoint.login,
      data:
      {
        'phone': phone,
        'password': password,
      },
    ).then((value)async {
      print(value.data);
      await CacheHelper.saveData(
          key: 'TokenId', value: value.data['access_token']);
      await CacheHelper.saveData(
          key: 'RefreshTokenId', value: value.data['refresh_token']);
                await CacheHelper.saveData(
          key: '_id', value: value.data['_id']);
      emit(LoginSuccessState(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(LoginErrorState(onError.response!.data['message']));
      }
    });
  }
}
