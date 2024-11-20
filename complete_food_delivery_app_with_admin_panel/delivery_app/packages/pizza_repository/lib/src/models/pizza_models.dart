import 'package:pizza_repository/src/entities/entities.dart';
import 'package:pizza_repository/src/models/models.dart';

class PizzaModels {
  String pizzaId;
  String picture;
  bool isVeg;
  int spicy;
  String name;
  String description;
  int price;
  int discount;
  Macros macros;

  PizzaModels({
    required this.pizzaId,
    required this.picture,
    required this.isVeg,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  PizzaEntities toEntity() {
    return PizzaEntities(
        pizzaId: pizzaId,
        picture: picture,
        isVeg: isVeg,
        spicy: spicy,
        name: name,
        description: description,
        price: price,
        discount: discount,
        macros: macros);
  }

  static PizzaModels fromEntity(PizzaEntities entity) {
    return PizzaModels(
        pizzaId: entity.pizzaId,
        picture: entity.picture,
        isVeg: entity.isVeg,
        spicy: entity.spicy,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        discount: entity.discount,
        macros: entity.macros);
  }
}
