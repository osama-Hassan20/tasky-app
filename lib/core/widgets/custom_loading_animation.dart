import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key, this.color});
final Color? color;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: color ?? const Color(0xff5F33E1),
        size: 50,
      ),
    );
  }
}
