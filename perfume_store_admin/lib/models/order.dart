import 'dart:convert';

import 'package:perfume_store_admin/models/user.dart';
import 'package:uuid/uuid.dart';

class MyOrder{
  final Map<String, dynamic> item;
  final String id;
  final DateTime orderDate;
  final MyUser user;
  final bool placed;

  MyOrder({required this.item, required this.orderDate, required this.user, this.placed=false, String? id}) 
    : id = id ?? const Uuid().v4();

  factory MyOrder.fromJson(Map<String, dynamic> order){
    return MyOrder(
      item: order['item'],
      id: order['id'],
      orderDate: DateTime.parse(order['orderDate']),
      user: MyUser.fromJson(jsonDecode(order['user'])),
      placed: order['placed']
    );
  }
  static Map<String, dynamic> toJson(MyOrder order){
    return {
      'item': order.item,
      'id': order.id,
      'orderDate': order.orderDate.toIso8601String(),
      'user': jsonEncode(MyUser.toJson(order.user)),
      'placed': order.placed
    };
  }

   MyOrder copyWith({
    Map<String, dynamic>? item,
    DateTime? orderDate,
    MyUser? user,
    bool? placed,
  }) {
    return MyOrder(
      item: item ?? this.item,
      orderDate: orderDate ?? this.orderDate,
      user: user ?? this.user,
      placed: placed ?? this.placed,
      id: id,
    );
  }
}