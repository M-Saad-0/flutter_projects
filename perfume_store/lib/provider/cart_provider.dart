import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perfume_store/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<MyOrder> _cart = [];
  List<MyOrder> get cart => _cart;
  bool _isLoading = true;
  bool get isLoading=>_isLoading;
  CartProvider() {
    _loadCartItems();
  }
  Future<void> _loadCartItems() async {
    _isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> cartItems = pref.getStringList('cart') ?? [];
    _cart = cartItems.map((e) {
      return MyOrder.fromJson(jsonDecode(e));
    }).toList();
    _isLoading = false;
    notifyListeners();
  }

  _saveCartItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(
        'cart', _cart.map((e) => jsonEncode(MyOrder.toJson(e))).toList());
  }

  addCartItem(MyOrder order) {
    _cart.add(order);
    _saveCartItems();
    notifyListeners();
  }

  deleteCartItem(MyOrder order) {
    _cart.removeWhere((e) =>
        e.id == order.id);
        _saveCartItems();
    notifyListeners();

  }
}
