import 'package:flutter/material.dart';
import 'package:tasky/features/auth/presentation/widgets/footer_register.dart';
import 'package:tasky/features/auth/presentation/widgets/register_body.dart';

import '../../../core/utils/size_config.dart';
import '../../../core/widgets/custom_image_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                  RegisterBody(),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2.4,
                  ),
                  const FooterRegister(),
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
