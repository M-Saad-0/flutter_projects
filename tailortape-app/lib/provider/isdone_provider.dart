import 'package:flutter/material.dart';

class IsDone extends ChangeNotifier {
  bool _isDone = false;
  bool get isDone => _isDone;
  setIsDone(bool isDone) {
    _isDone = isDone;
    notifyListeners();
  }
}
