import 'package:hive_flutter/adapters.dart';
import 'package:home_budgeting/models/expanse.dart';

class ExpanseServcie {
  List<Expanse> getAllExpanses() {
    final Box<Expanse> box = Hive.box("expanse");
    final expanses = box.values.toList();
    return expanses;
  }

  Future<Expanse> addExpanse(Expanse expanse) async {
    final Box<Expanse> box = Hive.box("expanse");
    box.put(expanse.date, expanse);
    return expanse;
  }

  Future<void> deleteExpanse(Expanse expanse) async {
    final Box<Expanse> box = Hive.box("expanse");
    box.delete(expanse.date);
  }

  Future<void> updateExpanse(Expanse expanse)async{
    final Box<Expanse> box = Hive.box("expanse");
    box.put(expanse.date, expanse);
  }

  
}
