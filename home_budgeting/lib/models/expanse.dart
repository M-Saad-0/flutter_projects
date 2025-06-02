import 'package:hive/hive.dart';
part 'expanse.g.dart';

@HiveType(typeId: 0)
class Expanse extends HiveObject {
  @HiveField(0)
  final String payee;
  @HiveField(1)
  final int price;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;




  Expanse({
    required this.payee,
    required this.description,
    required this.price,
    required this.date,
  });





  factory Expanse.fromJson(Map<String, dynamic> expanseJson) {
    return Expanse(
      payee: expanseJson['payee'],
      description: expanseJson['description'],
      price: expanseJson['price'],
      date: expanseJson['date'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'payee': payee,
      'price': price,
      'description': description,
      'date': date,
    };
  }
}
