import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/features/auth/presentation/login_view.dart';

import '../../../../core/utils/local_service_helper/cache_helper.dart';
import '../../../../core/utils/local_service_helper/constant.dart';

void singOut(context) {
  CacheHelper.clearData(key: 'RefreshTokenId').then((value) {
    CacheHelper.clearData(key: 'TokenId').then(
          (value) {
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
