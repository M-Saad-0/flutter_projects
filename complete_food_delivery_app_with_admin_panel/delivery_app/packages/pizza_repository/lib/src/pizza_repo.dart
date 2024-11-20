import 'package:pizza_repository/pizza_repository.dart';

abstract class PizzaRepo {
  Future<List<PizzaModels>> getPizza();
}