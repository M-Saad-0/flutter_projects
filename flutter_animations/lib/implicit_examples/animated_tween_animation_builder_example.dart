import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatelessWidget {
  const PulsatingCircleAnimation({super.key});
  final double size = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulsating Circle Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 30),
          tween: Tween<double>(begin: 0, end: 1000),
          builder: (context, object, widget) {
            return Container(
              width: object,
              height: object,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: object,
                    spreadRadius: object / 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget!,
                  Text(object.toString())
                ],
              ),
            );
          },
          child: const Text("Going fast"),
        ),
      ),
    );
  }
}
