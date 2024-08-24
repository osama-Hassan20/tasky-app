import 'cache_helper.dart';

String? token = CacheHelper.getData(key: 'TokenId');
String? refreshToken = CacheHelper.getData(key: 'RefreshTokenId');
String? id = CacheHelper.getData(key: '_id');
bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

