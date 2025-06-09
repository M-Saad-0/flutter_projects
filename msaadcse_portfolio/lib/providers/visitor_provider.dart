import 'package:flutter/material.dart';
import 'package:msaadcse_portfolio/services/firebase_stream.dart';

class VisitorProvider extends ChangeNotifier{
  final FirebaseStream _firebaseStream = FirebaseStream();
  Map<String, dynamic> _stats = {"total_visitors": 0, "live_visitors": 0};

  Map<String, dynamic> get stats =>_stats;

  FirebaseStream get db => _firebaseStream;

  void listenToVisitors(){
    _firebaseStream.porfolioStream.listen((data){
      _stats = data;
      notifyListeners();
    });
  }
  
}