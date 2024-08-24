import 'package:flutter/material.dart';

class NewsCardSkelton extends StatefulWidget {
  const NewsCardSkelton({Key? key}) : super(key: key);

  @override
  _NewsCardSkeltonState createState() => _NewsCardSkeltonState();
}

class _NewsCardSkeltonState extends State<NewsCardSkelton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
 late Animation<double> animation;
 

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 64, width: 64),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ShimmerEffect(
                      child: const Skeleton(),
                      animation: animation,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ShimmerEffect(
                      child: const Skeleton(),
                      animation: animation,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: ShimmerEffect(
                      child: const Skeleton(),
                      animation: animation,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ShimmerEffect(
                child: const Skeleton(),
                animation: animation,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: ShimmerEffect(
                      child: const Skeleton(),
                      animation: animation,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ShimmerEffect(
                      child: const Skeleton(),
                      animation: animation,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(width: 22),
      ],
    );
  }
    void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = Tween<double>(begin: 0.2, end: 1).animate(
      animationController,
    );
    animationController.repeat(
      reverse: true,
    );
  }
  
}


class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              Colors.grey,
              Colors.grey,
              Colors.grey,
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds);
        },
        child: child,
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16 / 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}