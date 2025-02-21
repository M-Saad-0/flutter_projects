import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  final double progress;
  final Color color;

  const RadialProgressAnimation({
    super.key,
    required this.progress,
    required this.color,
  });

  @override
  State<RadialProgressAnimation> createState() => _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> loadingAnimation;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    loadingAnimation = Tween<double>(begin: 0, end: widget.progress).animate(controller);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: loadingAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: loadingAnimation.value,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade100,
                    color: widget.color,
                  ),
                ),
                Text(
                  '${(loadingAnimation.value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(controller.isCompleted){
                controller.reverse();
          }else{
                controller.forward();
          }
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}
