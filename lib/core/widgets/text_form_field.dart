import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

Widget customTextFormField({
  TextEditingController? controller,
  required BuildContext context,
  required TextInputType type,
  bool? isPassword,
  bool? readOnly,
  TextStyle? hintStyle,
  String? hintText,
  FormFieldValidator<String>? validate,
  Widget? suffix,
  TextStyle? style,
  IconData? prefix,
  double? borderWidth,
  Color? borderColor,
  int? maxLines,
  Color? color,
  // VoidCallback? suffixPressed,
}) =>
    TextFormField(
      readOnly: readOnly ?? false,
      controller: controller,
      style: style,
      keyboardType: type,
      obscureText: isPassword ?? false,
      validator: validate,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintStyle: hintStyle ??
            AppStyles.styleRegular14(context)
                .copyWith(color: const Color(0xff7F7F7F)),
        hintText: hintText ?? '',
        prefixIcon: prefix != null
            ? Icon(
          prefix,
          color: const Color(0xff5F33E1),
        ) : null,
        fillColor:color ?? Colors.transparent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(width: borderWidth ?? 1, color: borderColor ??const Color(0xFFBABABA)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth ?? 1, color: borderColor ??const Color(0xFFBABABA)),
          borderRadius: BorderRadius.circular(10)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth ?? 1, color: borderColor ??const Color(0xFFBABABA)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
