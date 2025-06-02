
import 'package:hive/hive.dart';
part 'ai_response.g.dart';

@HiveType(typeId: 1)
class AiRespone extends HiveObject{
  @HiveField(0)
  final String query;
  @HiveField(1)
  final String reponse;
  @HiveField(2)
  final String date;

  AiRespone({required this.query, required this.reponse, required this.date});
  factory AiRespone.fromJson(Map<String, dynamic> json) {
    return AiRespone(
      query: json['query'] as String,
      reponse: json['reponse'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'reponse': reponse,
      'date': date,
    };
  }
}