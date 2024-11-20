import 'package:flutter/material.dart';

class ThememodeIdentifier {
  bool tell(BuildContext context) {
    var brightness = Theme.of(context).brightness == Brightness.dark;
    return brightness;
  }
}
