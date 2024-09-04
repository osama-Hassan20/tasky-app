import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/api_healper/dio_helper.dart';
import 'package:tasky/core/utils/api_healper/end_point.dart';

import '../local_service_helper/cache_helper.dart';
import '../local_service_helper/constant.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    if (err.response?.statusCode == 401) {
      await _refreshToken();
      err.requestOptions.headers['Authorization'] = 'Bearer $token';
      return handler.resolve(await DioHelper.dio.fetch(err.requestOptions));
    }

    return handler.next(err);
  }

  bool refreshDone = false;

  Future<bool> _refreshToken() async {
    refreshToken = CacheHelper.getData(key: 'RefreshTokenId');
    print(refreshToken);
    DioHelper.getDate(
      url: '${EndPoint.refreshToken}${refreshToken}',
    ).then((value) async {
      await CacheHelper.clearData(key: 'TokenId');

      await CacheHelper.saveData(
          key: 'TokenId', value: value.data['access_token']);
      token = CacheHelper.getData(key: 'TokenId');
      refreshDone = true;
    }).catchError((e) {
      print('refreshToken');
      print(refreshToken);
      refreshDone = false;
    });
    if (kDebugMode) {
      print('refreshDone = $refreshDone');
      print('object');
      print(token);
    }
    return refreshDone;
  }
}
