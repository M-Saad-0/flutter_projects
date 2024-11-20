class MacrosEntities {
  int calories;
  int protien;
  int fat;
  int carbs;
  MacrosEntities(
      {required this.calories,
      required this.carbs,
      required this.fat,
      required this.protien});

      Map<String, Object?> toDocument() {
    return {
      'calories': calories,
      'protien': protien,
      'fat': fat,
      'carbs': carbs,
     
    };
  }

  static MacrosEntities fromDocument(Map<String, dynamic> doc) {
    return MacrosEntities(
        calories: doc['calories'],
        protien: doc['protien'],
        fat: doc['fat'],
        carbs: doc['carbs'],
);
  }
}
