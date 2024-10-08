import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SizeConfig{
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context){
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape ? screenHeight! * .024 : screenWidth! * .024 ;
    if (kDebugMode) {
      print('this is the default size $defaultSize');
      print('this is the default HeightSize $screenHeight');
      print('this is the default WidthSize $screenWidth');
      print('this is the default WidthSize $orientation');
    }
  }
}