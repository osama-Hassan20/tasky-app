import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/api_healper/api_interceptor.dart';
import '../local_service_helper/cache_helper.dart';
import '../local_service_helper/constant.dart';
import 'end_point.dart';

class DioHelper {
  static late Dio dio;

  static inti() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoint.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    // dio.interceptors.add(di.serviceLocator<ApiInterceptor>());
    dio.interceptors.add(ApiInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }
  }

  static Future<Response> getRequest({
    required String url,
    required Map<String,dynamic>? query ,
    required dynamic data,
    required Options option,
})async{
    return await dio.request<dynamic>(
        url,
        data: data,
        queryParameters: query,
        options: option
    );
}


  static Future<Response> getDate({
    required String url,
    Map<String,dynamic>? query ,
    dynamic data,
    String tokenVerify = ''
  }) async
  {
    token = CacheHelper.getData(key: 'TokenId');
    // dio.options.headers = {
    //   'Authorization':'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
    // };
    return await dio.get(
      url ,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query ,
    required dynamic data ,
    String tokenVerify = '',
    bool isFormData = false,
  }) async
  {
    token = CacheHelper.getData(key: 'TokenId');
    dio.options.headers = {
    //   'Authorization':'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
      'Content-Type':isFormData?'multipart/form-data; boundary=<calculated when request is sent>':'application/json'
    };
    return dio.post(
      url ,
      queryParameters: query,
      data: isFormData? FormData.fromMap(data) :data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query ,
    required dynamic data ,
  }) async
  {
    token = CacheHelper.getData(key: 'TokenId');
    // dio.options.headers = {
    //   'Authorization':'Bearer $token',
    // };
    return dio.put(
      url ,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    dynamic data,
  }) async
  {
    token = CacheHelper.getData(key: 'TokenId');
    // dio.options.headers = {
    //   'Authorization':'Bearer $token',
    // };
    return dio.delete(
      url ,
      data: data,
    );
  }



}
