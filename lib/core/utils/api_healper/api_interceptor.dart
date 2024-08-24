import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/api_healper/dio_helper.dart';
import 'package:tasky/core/utils/api_healper/end_point.dart';

import '../local_service_helper/cache_helper.dart';
import '../local_service_helper/constant.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
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
      token = CacheHelper.getData(key: 'TokenId');
      if (token != null) {
        if (await _refreshToken()) {
          return handler.resolve(await _retry(err.requestOptions));
        }
      }
    }

    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return DioHelper.getRequest(
        url: requestOptions.path,
        query: requestOptions.queryParameters,
        data: requestOptions.data,
        option: options);
  }

  bool refreshDone = false;

  Future<bool> _refreshToken() async {
    DioHelper.getDate(
        url: EndPoint.refreshToken,
        query: {AppStrings.token: refreshToken}).then((value) async {
      await CacheHelper.clearData(key: 'TokenId');

      await CacheHelper.saveData(
          key: 'TokenId', value: value.data['access_token']);
      token = CacheHelper.getData(key: 'TokenId');
      refreshDone = true;
    }).catchError((e) {
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
