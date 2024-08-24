import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/api_healper/end_point.dart';
import 'package:tasky/features/profile/presentation/manager/cubit/state.dart';

import '../../../../../core/utils/api_healper/dio_helper.dart';
import '../../../domain/models/UserModel.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);


  UserModel? userModel;
  Future<void> getUser() async{
    emit(ProfileLoadingState());
    await DioHelper.getDate(
      url: EndPoint.profile,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ProfileSuccessState());
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(ProfileErrorState(onError.response!.data['message']));
      }
    });
  }
}
