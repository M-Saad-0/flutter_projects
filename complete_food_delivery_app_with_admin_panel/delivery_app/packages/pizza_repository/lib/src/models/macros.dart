import 'package:pizza_repository/src/entities/macros_entities.dart';

class Macros {
  int calories;
  int protien;
  int fat;
  int carbs;
  Macros(
      {required this.calories,
      required this.carbs,
      required this.fat,
      required this.protien});

  MacrosEntities toEntity() {
    return MacrosEntities(
      calories: calories,
      protien: protien,
      fat: fat,
      carbs: carbs,
    );
  }

  static Macros fromEntity(MacrosEntities entity) {
    return Macros(
      calories: entity.calories,
      protien: entity.protien,
      fat: entity.fat,
      carbs: entity.carbs,
    );
  }
}
