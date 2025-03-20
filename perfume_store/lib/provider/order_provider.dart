import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/models/order.dart';
import 'package:uuid/uuid.dart';

class OrderProvider extends ChangeNotifier {
  List<MyOrder> _order = [];
  List<MyOrder> get order => _order;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrderProvider() {
    _loadorderItems();
  }

  Future<void> _loadorderItems() async {
    _isLoading = true;
    notifyListeners();
    try {
      String? email = FirebaseAuth.instance.currentUser?.email;
      QuerySnapshot query = await _firestore.collection('orders').where('user.email', isEqualTo: email??const Uuid().v1()).get();
      _order = query.docs
          .map((e) => MyOrder.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("Error loading order: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addOrderItem(MyOrder order) async {
    try {
      Map<String, dynamic> orderData = MyOrder.toJson(order);
      await _firestore.collection('orders').add(orderData);
      _order.add(order);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding order: $e");
    }
  }

  Future<void> deleteOrderItem(MyOrder order) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('id', isEqualTo: order.id)
          .get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      _order.removeWhere((e) =>
          e.id == order.id
         );
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting the order: $e");
    }
  }

  Future<void> placeOrder(MyOrder order) async {
    try {
      QuerySnapshot ordersToPlace = await _firestore
          .collection("orders")
          .where('id', isEqualTo: order.id).get();
      if (ordersToPlace.docs.isNotEmpty) {
        await ordersToPlace.docs.first.reference.update({'placed': true});
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error placing order: $e");
    }
  }
}
