import 'package:flutter/material.dart';
import 'package:tasky/features/splash/presentation/widgets/splash_view_body.dart';

import '../../../core/utils/local_service_helper/constant.dart';
import '../../../core/utils/navigate.dart';
import '../../auth/presentation/login_view.dart';
import '../../home/presentation/home_view.dart';
import '../../next_splash/presentation/next_splash_view.dart';

class SplashView extends StatefulWidget {

  const SplashView({super.key,});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    initSlidingAnimation();
    goToNextView();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5F33E1),
      body: SplashViewBody(
        animation: animation!,
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = Tween<double>(begin: 0.2, end: 1).animate(
      animationController!,
    );
    animationController?.repeat(
      reverse: true,
    );
  }
  Widget? nextSplashWidget;
  void goToNextView() async {
    if (onBoarding != null) {
      if (token != null) {
        nextSplashWidget = const HomeView();
      } else {
        nextSplashWidget = const LoginView();
      }
    } else {
      nextSplashWidget = const NextSplashView();
    }
    await Future.delayed(const Duration(seconds: 4), () {
      navigateAndFinish(context, nextSplashWidget);
    });
  }
}
