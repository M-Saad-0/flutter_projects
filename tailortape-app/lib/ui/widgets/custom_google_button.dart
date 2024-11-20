import 'package:flutter/material.dart';
import 'package:tailortape/utils/thememode_identifier.dart';

class GoogleButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const GoogleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [
      Color(0xff088AF9),
      Color(0xffFF4737),
      Color(0xffFEBF08),
      Color(0xff088AF9),
      Color(0xffFF4737),
    ]),
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: isDarkMode ? Colors.white : Colors.black),
            borderRadius: borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  image: AssetImage("assets/icons/googlelogo.png")),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
              ),
              child: child,
            ),
          ),
        ));
  }
}
