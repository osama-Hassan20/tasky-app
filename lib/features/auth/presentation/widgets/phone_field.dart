import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/utils/app_styles.dart';

class PhoneField extends StatelessWidget {
  const PhoneField(
      {super.key, required this.controller, required this.validate});

  final TextEditingController controller;
  final FutureOr<String?> Function(PhoneNumber?) validate;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      disableLengthCheck: false,
      flagsButtonPadding: const EdgeInsets.only(left: 10),
      dropdownIconPosition: IconPosition.trailing,
      dropdownIcon: const Icon(Icons.keyboard_arrow_down_sharp,color: Color(0xff7F7F7F),),
      decoration: InputDecoration(
        alignLabelWithHint: false,
        // hintText: '123 456-7890',

        hintStyle: AppStyles.styleRegular14(context),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      initialCountryCode: 'EG',
      validator: validate,
    );
  }
}
