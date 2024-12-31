class ExpenseModel {
  final String id;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String payee;
  final String note;
  final String tag;

  const ExpenseModel(
      {required this.id,
      required this.amount,
      required this.categoryId,
      required this.date,
      required this.payee,
      required this.note,
      required this.tag});

  factory ExpenseModel.fromJson(Map<String, dynamic> expenseMap) {
    return ExpenseModel(
        id: expenseMap['id'],
        amount: expenseMap['amount'],
        categoryId: expenseMap['categoryId'],
        date: DateTime.parse(expenseMap["date"]),
        payee: expenseMap['payee'],
        note: expenseMap['note'],
        tag: expenseMap['tag']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'date': date.toString(),
      'payee': payee,
      'note': note,
      'tag': tag,
    };
  }
}
