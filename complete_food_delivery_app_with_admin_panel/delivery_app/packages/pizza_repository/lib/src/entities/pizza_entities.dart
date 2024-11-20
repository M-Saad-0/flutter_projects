import 'package:pizza_repository/src/entities/entities.dart';
import 'package:pizza_repository/src/models/models.dart';

class PizzaEntities {
  String pizzaId;
  String picture;
  bool isVeg;
  int spicy;
  String name;
  String description;
  int price;
  int discount;
  Macros macros;

  PizzaEntities({
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

  Map<String, Object?> toDocument() {
    return {
      'pizzaId': pizzaId,
      'picture': picture,
      'isVeg': isVeg,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toEntity().toDocument(),
    };
  }

  static PizzaEntities fromDocument(Map<String, dynamic> doc) {
    return PizzaEntities(
        pizzaId: doc['pizzaId'],
        picture: doc['picture'],
        isVeg: doc['isVeg'],
        spicy: doc['spicy'],
        name: doc['name'],
        description: doc['description'],
        price: doc['price'],
        discount: doc['discount'],
        macros: Macros.fromEntity(MacrosEntities.fromDocument(doc['macros'])));
  }
}
