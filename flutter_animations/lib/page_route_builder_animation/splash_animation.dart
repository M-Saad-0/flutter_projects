import 'dart:async';

import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    sizeAnimation = Tween<double>(begin: 1, end: 10).animate(controller);
    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.push(
            context,
            MyCustomeRouteTransition(route: const Destination()));
        Timer(const Duration(seconds: 1), () {
          controller.reset();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: sizeAnimation,
          child: GestureDetector(
            onTap: () {
              controller.forward();
              if (sizeAnimation.isCompleted) {}
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  const Destination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
    );
  }
}

class MyCustomeRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomeRouteTransition({required this.route})
      : super(pageBuilder: (context, animation, secondaryAnimation) {
          return route;
        },
        transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
              // return FadeTransition(opacity: animation,
              // child: child,);
              return SlideTransition(
                position:
                    Tween(begin: const Offset(0, .4), end: const Offset(0, 0))
                        .animate(animation),
                child: child,
              );
            }
        );
}
