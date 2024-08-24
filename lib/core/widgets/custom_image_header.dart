import 'package:flutter/material.dart';
import 'package:tasky/core/utils/size_config.dart';

import '../utils/app_images.dart';

class CustomImageHeader extends StatelessWidget {
  const CustomImageHeader({super.key, this.aspectRatio});
  final double? aspectRatio;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio ?? 375 / 482,
      child: Image.asset(
        ImageAssets.authHeaderImage,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
