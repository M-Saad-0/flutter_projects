import 'package:expanse_manager/models/expense_model.dart';
import 'package:expanse_manager/pages/home_page.dart';
import 'package:expanse_manager/providers/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Your Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Amount"),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter amount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Category"),
              DropdownMenu(
                width: MediaQuery.sizeOf(context).width-32,
                  hintText: "Add Category",
                  controller: _categoryIdController,
                  dropdownMenuEntries: Provider.of<ExpenseProvider>(context)
                      .categories
                      .map((e) => DropdownMenuEntry(
                          value: e.categoryName, label: e.categoryName))
                      .toList()),
                      const SizedBox(height: 16),
              const Text("Tag"),
              DropdownMenu(
                width: MediaQuery.sizeOf(context).width-32,
                  hintText: "Add Tag",
                  controller: _tagController,
                  dropdownMenuEntries: Provider.of<ExpenseProvider>(context)
                      .tags
                      .map((e) =>
                          DropdownMenuEntry(value: e.tagName, label: e.tagName))
                      .toList()),
              const SizedBox(height: 16),
              const Text("Payee"),
              TextField(
                controller: _payeeController,
                decoration: const InputDecoration(
                  hintText: "Enter payee name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Note"),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Add a note (optional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Date"),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        _dateController.text =
                            (await _showDatePicker(context)).toString();
                      },
                      icon: const Icon(Icons.date_range)),
                  hintText: "Select a date",
                  border: const OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final amount = _amountController.text;
                    final categoryId = _categoryIdController.text;
                    final payee = _payeeController.text;
                    final note = _noteController.text;
                    final tags = _tagController.text;

                    if (amount.isEmpty || categoryId.isEmpty || payee.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all required fields."),
                        ),
                      );
                    } else {
                      final expenseModel = ExpenseModel(
                        id: DateTime.now().toIso8601String(),
                        amount: double.parse(amount),
                        categoryId: categoryId,
                        date: DateTime.parse(_dateController.text),
                        payee: payee,
                        note: note,
                        tag: tags,
                      );

                      Provider.of<ExpenseProvider>(context, listen: false)
                          .addExpense(expenseModel);
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Expense added successfully!")),
                      );
                    }
                  },
                  child: const Text("Submit Expense"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> _showDatePicker(BuildContext context) async {
    return await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        ) ??
        DateTime.now();
  }

  void _submitExpense() {}

  @override
  void dispose() {
    _amountController.dispose();
    _categoryIdController.dispose();
    _payeeController.dispose();
    _noteController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}
