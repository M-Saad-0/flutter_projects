import 'package:expanse_manager/models/category_model.dart';
import 'package:expanse_manager/models/expense_model.dart';
import 'package:expanse_manager/providers/expanse_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: ListView.builder(
          itemCount: Provider.of<ExpenseProvider>(context).categories.length,
          itemBuilder: (context, index) {
            final category =
                Provider.of<ExpenseProvider>(context).categories[index];
            return ListTile(
              title: Text(category.categoryName),
              trailing: IconButton(
                  onPressed: () {
                    Provider.of<ExpenseProvider>(context, listen: false)
                        .removeCategory(category);
                  },
                  icon: const Icon(Icons.delete)),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Add Category"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: "Enter Category Name"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Provider.of<ExpenseProvider>(context, listen: false).addCategories(
                                CategoryModel(
                                    categoryName: _nameController.text,
                                    id: DateTime.timestamp().toString()));
                                    _nameController.text="";
                                    Navigator.pop(context);
                          },
                          child: const Text("Add Category"))
                    ],
                  ),
                ));
      },child: Icon(Icons.add),),
    );
  }
}
