import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation> with SingleTickerProviderStateMixin{
 late AnimationController controller;
 late Animation<double> animation;
 @override
 void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
    controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      } else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: BouncingBallPainter(animationValue: animation.value),
                  size: const Size(200, 300),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}


class BouncingBallPainter extends CustomPainter{
  final double animationValue;
  const BouncingBallPainter({required this.animationValue});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width, size.height - (animationValue*size.height)), 20, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}