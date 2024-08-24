import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_image_header.dart';
import 'package:tasky/features/auth/presentation/login_view.dart';
import 'package:tasky/features/next_splash/presentation/widgets/custom_info_app.dart';

import '../../../../core/utils/local_service_helper/cache_helper.dart';

class NextSplashViewBody extends StatelessWidget {
  const NextSplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomImageHeader(),
          const CustomInfoApp(),
          Padding(
            padding: const EdgeInsets.all(22),
            child: CustomButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value: true)
                    .then((value) {
                  if (value == true) {
                    navigateAndFinish(context, const LoginView());
                  }
                });
              },
              text: 'Let’s Start',
              style: AppStyles.styleBold19(context),
              widget: SvgPicture.asset(
                ImageAssets.arrowIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
