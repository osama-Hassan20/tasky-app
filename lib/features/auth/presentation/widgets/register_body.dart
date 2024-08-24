import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/features/auth/presentation/manger/register_cubit/cubit.dart';
import 'package:tasky/features/auth/presentation/widgets/phone_field.dart';
import 'package:tasky/core/widgets/text_form_field.dart';
import '../../../../core/utils/navigate.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_loading_animation.dart';
import '../../../../core/widgets/custom_title_text.dart';
import '../../../home/presentation/home_view.dart';
import '../manger/register_cubit/states.dart';
import 'level_dropdown_menu.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({super.key});

  final fromKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experienceYearsController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static String countryCode = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterSuccessState) {
            CherryToast.success(
              title: Text(
                  ' ${state.successModel['displayName']}Login Successfully'),
              animationType: AnimationType.fromTop,
            ).show(context);
            navigateAndFinish(context, const HomeView());
          } else if (state is RegisterErrorState) {
            CherryToast.error(
              title: Text(state.errorModel!),
              animationType: AnimationType.fromTop,
            ).show(context);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                    aspectRatio: 375 / 345,
                    // child: SizedBox(),
                  ),
                  const CustomTitleText(text: 'Sign up'),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 2.4,
                  ),
                  customTextFormField(
                      controller: nameController,
                      context: context,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      hintText: 'Name...',
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 1.5,
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
                    height: SizeConfig.defaultSize! * 1.5,
                  ),
                  customTextFormField(
                    controller: experienceYearsController,
                    context: context,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Experience is required';
                      }
                      return null;
                    },
                    hintText: 'Years of experience...',
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 1.5,
                  ),
                  customTextFormField(
                    controller: levelController,
                    readOnly: true,
                    context: context,
                    type: TextInputType.visiblePassword,
                    isPassword: false,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Choose experience Level';
                      }
                      return null;
                    },
                    hintText: 'Choose experience Level',
                    hintStyle: AppStyles.styleMedium14(context),
                    suffix: levelDropdownMenu(onChanged: (value){
                      levelController.text = value.toString();
                    }),

                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 1.5,
                  ),
                  customTextFormField(
                    controller: addressController,
                    context: context,
                    type: TextInputType.streetAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                    hintText: 'Address...',
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 1.5,
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
                    text: state is RegisterLoadingState ? 'Loading...' : 'Sign up',
                    widget: state is RegisterLoadingState ? const CustomLoadingAnimation(color: Colors.white,) : const SizedBox(),
                    onPressed: (){
                      if(fromKey.currentState!.validate()){
                        cubit.userRegister(
                          username: nameController.text,
                          phone: countryCode + phoneController.text,
                          password: passwordController.text,
                          experienceYears: int.parse(experienceYearsController.text),
                          address: addressController.text,
                          level: levelController.text,
                        );
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


