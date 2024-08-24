import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/features/auth/presentation/login_view.dart';
import 'package:tasky/features/auth/presentation/widgets/text_button.dart';

import '../../../../core/utils/size_config.dart';

class FooterRegister extends StatelessWidget {
  const FooterRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize! * 2.4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have any account? ',
            style: AppStyles.styleRegular14(context).copyWith(
              color: const Color(0xff7F7F7F),
            ),
          ),
          defaultTextButton(
            function: () {
              navigateTo(context, const LoginView());
            },
            text: 'Sign in',
            context: context,
          ),
        ],
      ),
    );
  }
}
