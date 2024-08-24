import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/navigate.dart';
import 'package:tasky/features/auth/presentation/widgets/phone_field.dart';
import 'package:tasky/core/widgets/text_form_field.dart';
import 'package:tasky/features/home/presentation/home_view.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_animation.dart';
import '../../../../core/widgets/custom_title_text.dart';
import '../manger/login_cubit/cubit.dart';
import '../manger/login_cubit/states.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final fromKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static String countryCode = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {
            CherryToast.success(
              title: const Text('Login Successfuly'),
              animationType: AnimationType.fromTop,
            ).show(context);


            navigateAndFinish(context, const HomeView());
          } else if (state is LoginErrorState) {
            CherryToast.error(
              title: Text(state.error),
              animationType: AnimationType.fromTop,
            ).show(context);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize! * 2.4,
            ),
            child: Form(
              key: fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AspectRatio(
                    aspectRatio: 375 / 450,
                    // child: SizedBox(),
                  ),
                  const CustomTitleText(text: 'Login'),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2.4,
                  ),
                  PhoneField(
                    controller: phoneController,
                    validate: (value) {
                      countryCode = value!.countryCode;
                      if (value.number.isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2,
                  ),
                  customTextFormField(
                    controller: passwordController,
                    context: context,
                    type: TextInputType.visiblePassword,
                    isPassword: cubit.isPasswordShown,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    hintText: 'Password...',
                    suffix: IconButton(
                      onPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      icon: Icon(cubit.suffix,color: const Color(0xffBABABA),),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2.4,
                  ),
                  CustomButton(
                    text: state is LoginLoadingState ? 'Loading...' : 'Sign In',
                    widget: state is LoginLoadingState
                        ? const CustomLoadingAnimation(
                            color: Colors.white,
                          )
                        : const SizedBox(),
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        // print(countryCode + phoneController.text);
                        cubit.userLogin(
                            phone: countryCode + phoneController.text,
                            password: passwordController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
