import 'package:hive/hive.dart';
import 'package:home_budgeting/core/constants/months.dart';
import 'package:home_budgeting/models/expanse.dart';
import 'package:home_budgeting/models/report.dart';

class MonthlyExpanseService {
  Future<ExpanseReport?> createAReport() async {
    final box = Hive.box<Expanse>("expanse");
    final allExpanse = box.values.toList();
    if(allExpanse.isEmpty){
      return null;
    }
    Map<String, dynamic> report = {};
    Map<String, Map<String, int>> totalPerMonth = {};
    Map<String, int> totalPerYear = {};
    for (var i in allExpanse) {
      final date = DateTime.parse(i.date);
      final month = months[date.month-1];
      final year = date.year.toString();
      report.putIfAbsent(year, () => {});
      report[year].putIfAbsent(month, () => []);
      report[year]![month]!.add(i.toJson());

      totalPerMonth.putIfAbsent(year, () => {});
      totalPerMonth[year]!.putIfAbsent(month, () => 0);

      if (totalPerMonth[month] == null) {
        totalPerMonth[year]![month] = i.price;
      } else {
        totalPerMonth[year]![month] = totalPerMonth[year]![month]! + i.price;
      }
      if (totalPerYear[year] == null) {
        totalPerYear[year] = i.price;
      } else {
        totalPerYear[year] = totalPerYear[year]! + i.price;
      }
    }
    final reportModel = ExpanseReport.fromJson(report, totalPerMonth, totalPerYear);
    return reportModel;
  }


  static storeDummyDate()async{
    List<Expanse> getDummyExpanses() {
  return [
    Expanse(payee: 'Grocery Store', description: 'Groceries', date: '2024-01-15', price: 1500),
    Expanse(payee: 'Electric Company', description: 'Electricity Bill', date: '2024-01-20', price: 3200),
    Expanse(payee: 'Water Supplier', description: 'Water Bill', date: '2024-02-05', price: 800),
    Expanse(payee: 'Internet Provider', description: 'Internet Bill', date: '2024-02-15', price: 2500),
    Expanse(payee: 'Coffee Shop', description: 'Meeting with friend', date: '2024-03-10', price: 600),
    Expanse(payee: 'Medical Store', description: 'Medicines', date: '2024-03-22', price: 1300),
    Expanse(payee: 'Clothing Store', description: 'Shirts and trousers', date: '2024-04-11', price: 4500),
    Expanse(payee: 'Fuel Station', description: 'Fuel refill', date: '2024-04-15', price: 1800),
    Expanse(payee: 'Restaurant', description: 'Dinner', date: '2024-05-07', price: 2200),
    Expanse(payee: 'Gym', description: 'Monthly subscription', date: '2024-05-20', price: 3000),
    Expanse(payee: 'Grocery Store', description: 'Groceries', date: '2025-01-10', price: 1600),
    Expanse(payee: 'Internet Provider', description: 'Internet Bill', date: '2025-01-25', price: 2500),
    Expanse(payee: 'Electric Company', description: 'Electricity Bill', date: '2025-02-05', price: 3100),
    Expanse(payee: 'Water Supplier', description: 'Water Bill', date: '2025-02-18', price: 900),
    Expanse(payee: 'Coffee Shop', description: 'Snacks', date: '2025-03-14', price: 750),
    Expanse(payee: 'Medical Store', description: 'Health Supplies', date: '2025-03-27', price: 1100),
    Expanse(payee: 'Fuel Station', description: 'Car Fuel', date: '2025-04-12', price: 1900),
    Expanse(payee: 'Clothing Store', description: 'New Clothes', date: '2025-04-30', price: 4000),
    Expanse(payee: 'Gym', description: 'Annual Membership', date: '2025-05-02', price: 10000),
    Expanse(payee: 'Restaurant', description: 'Family dinner', date: '2025-05-21', price: 2800),
 
  Expanse(payee: 'Grocery Store', description: 'Groceries', date: '2024-01-15', price: 1500),
  Expanse(payee: 'Electric Company', description: 'Electricity Bill', date: '2024-01-20', price: 3200),
  Expanse(payee: 'Water Supplier', description: 'Water Bill', date: '2024-02-05', price: 800),
  Expanse(payee: 'Internet Provider', description: 'Internet Bill', date: '2024-02-15', price: 2500),
  Expanse(payee: 'Coffee Shop', description: 'Meeting with friend', date: '2024-03-10', price: 600),
  Expanse(payee: 'Medical Store', description: 'Medicines', date: '2024-03-22', price: 1300),
  Expanse(payee: 'Clothing Store', description: 'Shirts and trousers', date: '2024-04-11', price: 4500),
  Expanse(payee: 'Fuel Station', description: 'Fuel refill', date: '2024-04-15', price: 1800),
  Expanse(payee: 'Restaurant', description: 'Dinner', date: '2024-05-07', price: 2200),
  Expanse(payee: 'Gym', description: 'Monthly subscription', date: '2024-05-20', price: 3000),
  Expanse(payee: 'Grocery Store', description: 'Groceries', date: '2025-01-10', price: 1600),
  Expanse(payee: 'Internet Provider', description: 'Internet Bill', date: '2025-01-25', price: 2500),
  Expanse(payee: 'Electric Company', description: 'Electricity Bill', date: '2025-02-05', price: 3100),
  Expanse(payee: 'Water Supplier', description: 'Water Bill', date: '2025-02-18', price: 900),
  Expanse(payee: 'Coffee Shop', description: 'Snacks', date: '2025-03-14', price: 750),
  Expanse(payee: 'Medical Store', description: 'Health Supplies', date: '2025-03-27', price: 1100),
  Expanse(payee: 'Fuel Station', description: 'Car Fuel', date: '2025-04-12', price: 1900),
  Expanse(payee: 'Clothing Store', description: 'New Clothes', date: '2025-04-30', price: 4000),
  Expanse(payee: 'Gym', description: 'Annual Membership', date: '2025-05-02', price: 10000),
  Expanse(payee: 'Restaurant', description: 'Family dinner', date: '2025-05-21', price: 2800),

  // 20 more with more diverse dates and payees
  Expanse(payee: 'Bookstore', description: 'Books purchase', date: '2023-06-10', price: 1200),
  Expanse(payee: 'Pharmacy', description: 'Vitamins', date: '2023-07-15', price: 600),
  Expanse(payee: 'Car Service', description: 'Oil change', date: '2023-08-05', price: 3500),
  Expanse(payee: 'Movie Theater', description: 'Movie tickets', date: '2023-09-12', price: 800),
  Expanse(payee: 'Bakery', description: 'Birthday cake', date: '2023-10-22', price: 1800),
  Expanse(payee: 'Electronics Store', description: 'Headphones', date: '2023-11-03', price: 4200),
  Expanse(payee: 'Pet Store', description: 'Pet food', date: '2023-12-15', price: 1500),
  Expanse(payee: 'Gas Station', description: 'Gas refill', date: '2024-06-18', price: 1900),
  Expanse(payee: 'Laundry', description: 'Clothes wash', date: '2024-07-20', price: 700),
  Expanse(payee: 'Taxi Service', description: 'Airport trip', date: '2024-08-01', price: 1600),
  Expanse(payee: 'Spa', description: 'Massage session', date: '2024-09-10', price: 3000),
  Expanse(payee: 'Hardware Store', description: 'Tools', date: '2024-10-08', price: 2300),
  Expanse(payee: 'Coffee Shop', description: 'Work meeting', date: '2024-11-15', price: 650),
  Expanse(payee: 'Supermarket', description: 'Monthly shopping', date: '2024-12-25', price: 5500),
  Expanse(payee: 'Gym', description: 'Personal trainer', date: '2025-06-05', price: 4000),
  Expanse(payee: 'Cinema', description: 'Popcorn & drinks', date: '2025-07-11', price: 900),
  Expanse(payee: 'Restaurant', description: 'Lunch with client', date: '2025-08-17', price: 3200),
  Expanse(payee: 'Internet Provider', description: 'Fiber upgrade', date: '2025-09-23', price: 3500),
  Expanse(payee: 'Electric Company', description: 'Bill payment', date: '2025-10-14', price: 2800),
  Expanse(payee: 'Water Supplier', description: 'Water charge', date: '2025-11-19', price: 950),

  ];
}

    final box = Hive.box<Expanse>('expanse');
for (final expanse in getDummyExpanses()) {
  box.add(expanse);
}
  }
}
