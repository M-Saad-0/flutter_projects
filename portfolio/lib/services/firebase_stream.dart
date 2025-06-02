import 'package:firebase_database/firebase_database.dart';

class FirebaseStream{
  DatabaseReference _reference = FirebaseDatabase.instance.ref("visitors");

  Future<void> incrementTotalVisitor()async{
    final visitorReference = _reference.child("total_visitors");
    await visitorReference.runTransaction((mutableData){
      final int currentValue = mutableData as int? ??0;
      mutableData = currentValue + 1;
      return Transaction.success(mutableData);
    });
  }

  Future<void> incrementLiveVisitor()async{
    final visitorReference = _reference.child("live_visitors");
    await visitorReference.runTransaction((mutableData){
      final int currentValue = mutableData as int? ??0;
      mutableData = currentValue + 1;
      return Transaction.success(mutableData);
    });
  }

  Future<void> decrementLiveVisitor()async{
    final visitorReference = _reference.child("live_visitors");
    await visitorReference.runTransaction((mutableData){
      final int currentValue = mutableData as int? ??0;
      mutableData = currentValue > 0 ? currentValue - 1 : 0;
      return Transaction.success(mutableData);
    });
  }

  Stream<Map<String, dynamic>> get porfolioStream{
    return _reference.onValue.map((event){
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data;
    });
  }

  
}