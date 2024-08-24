import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_image_header.dart';
import 'package:tasky/features/auth/presentation/widgets/footer_login.dart';
import 'package:tasky/features/auth/presentation/widgets/login_body.dart';

import '../../../core/utils/size_config.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              const CustomImageHeader(),
              Column(
                children: [
                  LoginBody(),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2.4,
                  ),
                  const FooterLogin(),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2.4,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
