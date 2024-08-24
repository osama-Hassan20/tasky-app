import 'package:flutter/material.dart';
import 'package:tasky/features/next_splash/presentation/widgets/next_splash_view_body.dart';

class NextSplashView extends StatelessWidget {
  const NextSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NextSplashViewBody(),
    );
  }
}
