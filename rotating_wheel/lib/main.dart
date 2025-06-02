import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final backgroundColor = Colors.white;
  final foregroundColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.square(
          dimension: 400,
          child: RotatingWheel(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            size: 400,
          ),
        ),
      ),
    );
  }
}

class RotatingWheel extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;
  const RotatingWheel({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.size
  });

  @override
  State<RotatingWheel> createState() => _RotatingWheel();
}

class _RotatingWheel extends State<RotatingWheel> with SingleTickerProviderStateMixin {
  Offset? panStart;
  double wheelThickness = 40;
  double? panStartRadian;
  double? deltaRadian;
  double? reverseReltaRadian;
  late AnimationController _animationController;
  late Animation<double> animation;


  
  Offset get center => Offset(widget.size/2, widget.size/2);
  _onPanStart(DragStartDetails details){
    panStart = details.localPosition;
    panStartRadian =  atan2(panStart!.dy-center.dy, panStart!.dy-center.dy);
    
  }
  _onPanUpdate(DragUpdateDetails details){
    final dragRadians =  atan2(details.localPosition.dy-center.dy, details.localPosition.dx-center.dx);
    deltaRadian = dragRadians - panStartRadian!;
    setState(() {
      
    });
  }
  _onPanEnd(DragEndDetails details){
    
    _animationController.addListener(() {
      setState(() {
        reverseReltaRadian = deltaRadian! * (1-_animationController.value);
      });
    },);
    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        reverseReltaRadian = null;
        deltaRadian = null;
      }
    },);

    setState(() {
      panStart = null;
    panStartRadian = null;
    // deltaRadian =null;
    });
_animationController.reset();
_animationController.animateTo(1, curve: Curves.bounceInOut, duration: Duration(seconds: 2));
  }


  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin:0, end: 1 ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final radians = reverseReltaRadian??deltaRadian??0;
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          

          onPanStart: _onPanStart,
          child: Transform.rotate(
            angle: radians,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: WheelPainter(
                      rotaion: 0,
                      thickness: wheelThickness,
                      foregroundColor: widget.foregroundColor,
                      backgroundColor: widget.backgroundColor,
                      
                    ),
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth/2)-wheelThickness/2,
                  child: Icon(
                    Icons.flutter_dash_outlined,
                    color: widget.backgroundColor,
                    size: wheelThickness,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WheelPainter extends CustomPainter {
  final double rotaion;
  final double thickness;
  final Color backgroundColor;
  final Color foregroundColor;
  const WheelPainter({
    required this.rotaion,
    required this.thickness,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(
      center,
      size.height / 2,
      Paint()
        ..color = foregroundColor
        ..style = PaintingStyle.fill
        // ..strokeWidth=thickness,
    );
    canvas.drawCircle(
      center,
      size.height / 2 - thickness,
      Paint()..color = backgroundColor..style=PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
