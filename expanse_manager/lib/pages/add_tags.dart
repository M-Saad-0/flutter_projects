import 'package:expanse_manager/models/tag_model.dart'; // Import your Tag model
import 'package:expanse_manager/providers/expanse_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTags extends StatefulWidget {
  const AddTags({super.key});

  @override
  State<AddTags> createState() => _AddTagsState();
}

class _AddTagsState extends State<AddTags> {
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
        title: const Text("Tags"),
      ),
      body: ListView.builder(
        itemCount: Provider.of<ExpenseProvider>(context).tags.length,
        itemBuilder: (context, index) {
          final tag = Provider.of<ExpenseProvider>(context).tags[index];
          return ListTile(
            title: Text(tag.tagName),
            trailing: IconButton(
              onPressed: () {
                Provider.of<ExpenseProvider>(context, listen: false)
                    .removeTag(tag);
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add Tag"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Tag Name",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Provider.of<ExpenseProvider>(context, listen: false)
                          .addTags(
                        TagModel(
                          tagName: _nameController.text,
                          id: DateTime.timestamp().toString(), // Replace with appropriate ID generation if needed
                        ),
                      );
                  _nameController.text="";
                      Navigator.pop(context); // Close the dialog after adding
                    },
                    child: const Text("Add Tag"),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}