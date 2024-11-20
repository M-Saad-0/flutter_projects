import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailortape/provider/loading_provider.dart';
import 'package:tailortape/utils/thememode_identifier.dart';

class MyElevatedButton extends StatefulWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final bool? isLoading;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [
      Color(0xff4B83F0),
      Color(0xffD46779),
    ]),
  });

  @override
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);

    final borderRadius = widget.borderRadius ?? BorderRadius.circular(0);
    return Consumer<LoadingProvider>(
      builder: (context, v, child) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white : Colors.black,
          borderRadius: borderRadius,
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: v.isLoading
              ? CircularProgressIndicator(
                  color: isDarkMode ? Colors.black : Colors.white)
              : widget.child,
        ),
      ),
    );
  }
}
