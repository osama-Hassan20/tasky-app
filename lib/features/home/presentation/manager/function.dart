import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/features/auth/presentation/login_view.dart';
import 'package:tasky/main.dart';

import '../../../../core/utils/local_service_helper/cache_helper.dart';
import '../../../../core/utils/local_service_helper/constant.dart';

void singOut(context) {
  // navigateAndFinish(
  //   context,
  //   const LoginView(),
  // );
  CacheHelper.clearData(key: 'RefreshTokenId').then((value) {
    CacheHelper.clearData(key: 'TokenId').then(
      (value) {
        token = CacheHelper.getData(key: 'TokenId');
        refreshToken = CacheHelper.getData(key: 'RefreshTokenId');
        navigateAndFinish(
          context,
          const LoginView(),
        );
        debugPrint(
          "token inside clear data : $token",
        );
      },
    );
  });
}

void forbiddenOut() {
  CacheHelper.clearData(key: 'RefreshTokenId').then((value) {
    CacheHelper.clearData(key: 'TokenId').then(
      (value) {
        token = CacheHelper.getData(key: 'TokenId');
        refreshToken = CacheHelper.getData(key: 'RefreshTokenId');

        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginView()),
          (Route<dynamic> route) => false,
        );
        debugPrint(
          "token inside clear data : $token",
        );
      },
    );
  });
}
