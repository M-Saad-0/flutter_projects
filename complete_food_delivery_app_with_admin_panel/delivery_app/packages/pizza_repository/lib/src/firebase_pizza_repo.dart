// import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_repository/pizza_repository.dart';

class FirebasePizzaRepo extends PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  Future<List<PizzaModels>> getPizza() async {
    try {
      return await pizzaCollection.get().then((value) => value.docs
          .map((e) =>
              PizzaModels.fromEntity(PizzaEntities.fromDocument(e.data())))
          .toList());
    } catch (e) {
      // log(e.toString());
      rethrow;
    }
  }
}
