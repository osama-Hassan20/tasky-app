import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_images.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key, required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 124 / 45,
        child: FadeTransition(
          opacity: animation,
          child: Image.asset(ImageAssets.appLogoImage),
        ),
      ),
    );
  }
}
