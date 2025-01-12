import 'package:expanse_manager/pages/add_categories.dart';
import 'package:expanse_manager/pages/add_expense_page.dart';
import 'package:expanse_manager/pages/add_tags.dart';
import 'package:expanse_manager/providers/expanse_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.sizeOf(context).width,
              color: Theme.of(context).primaryColor,
              child: Text("Manage Categories and Tags",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCategories()));
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.category_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Manage Categories",
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                )),
            const Divider(),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddTags()));
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.tag),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Manage Tags"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ))
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Your Expenses"),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.data_exploration_outlined),
              text: "By Date",
            ),
            Tab(
              icon: Icon(Icons.category),
              text: "By Category",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          // Tab 1: Expenses by Date
          Consumer<ExpenseProvider>(
            builder: (context, provider, child) => ListView.builder(
              itemCount: provider.expenses.length,
              itemBuilder: (context, index) {
                final expense = provider.expenses[index];
                return Dismissible(
                  key: Key(expense.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Warning"),
                              content: Text("Are you sure you want to delete ${expense.tag} expanse?"),
                              actions: [TextButton(onPressed: (){
                                provider.removeExpanse(expense);
                                Navigator.of(context).pop();}, child: const Text("Delete")),TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Cancel"))],
                            ));
                  },
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.monetization_on),
                    ),
                    title: Text(
                      "${expense.tag} - \$${expense.amount}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      "${DateFormat('yyyy-MM-dd').format(expense.date)} - ${expense.categoryId}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
            ),
          ),
          // Tab 2: Expenses by Category
          Consumer<ExpenseProvider>(
            builder: (context, provider, child) => ListView.builder(
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                final expenseByCategory = provider.expenses
                    .where((e) =>
                        e.categoryId == provider.categories[index].categoryName)
                    .toList();

                return expenseByCategory.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          Text(
                            textAlign: TextAlign.left,
                            provider.categories[index].categoryName,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          ...expenseByCategory
                              .map((e) => ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.monetization_on),
                                    ),
                                    title: Text(
                                      "${expenseByCategory[index].tag} - ${expenseByCategory[index].amount} RS",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    subtitle: Text(
                                      "Category: ${expenseByCategory[index].categoryId}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ))
                              .toList()
                        ],
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddExpensePage()));
          },
          child: const Icon(Icons.add)),
    );
  }
}
