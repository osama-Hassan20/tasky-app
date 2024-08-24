import 'package:flutter/material.dart';

abstract class AppStyles {
  //9
  static TextStyle styleRegular9(context) {
    return TextStyle(
      color: const Color(0xFF6E6A7C),
      fontSize: getResponsiveFontSize(context, fontSize: 9),
      fontWeight: FontWeight.w400,
    );
  }

  //12
  static TextStyle styleMedium12(context) {
    return TextStyle(
      color: const Color(0xFF2F2F2F).withOpacity(0.4),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMediumStatus12(status,context) {
    return TextStyle(
      color: status == 'waiting' || status ==  'high'
          ? const Color(0xFFFF7D53)
          : status == 'inprogress'|| status ==  'medium'
              ? const Color(0xFF5F33E1)
              : const Color(0xFF0087FF),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleRegular12(context) {
    return TextStyle(
      color: const Color(0xFF24252C).withOpacity(0.6),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w400,
    );
  }

  //14
  static TextStyle styleRegular14(context) {
    return TextStyle(
      color: const Color(0xFF7C7C80),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleMedium14(context) {
    return TextStyle(
      color: const Color(0xFF2F2F2F),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleBol14(context) {
    return TextStyle(
      color: const Color(0xFF5F33E1),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
  }

  //16
  static TextStyle styleRegular16(context) {
    return TextStyle(
      color: const Color(0xFF6E6A7C),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleMedium16(context) {
    return TextStyle(
      color: const Color(0xFF00060D),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleBold16(context) {
    return TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w700,
    );
  }

  //18
  static TextStyle styleBold18(context) {
    return TextStyle(
      color: const Color(0xFF2F2F2F).withOpacity(0.6),
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w700,
    );
  }

  //19
  static TextStyle styleBold19(context) {
    return TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 19),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium19(context) {
    return TextStyle(
      color: const Color(0xFF5F33E1),
      fontSize: getResponsiveFontSize(context, fontSize: 19),
      fontWeight: FontWeight.w500,
    );
  }

  //24
  static TextStyle styleBold24(context) {
    return TextStyle(
      color: const Color(0xFF24252C),
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontWeight: FontWeight.w700,
    );
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return (responsiveFontSize.clamp(lowerLimit, upperLimit)+1);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  return width / 550;
}
