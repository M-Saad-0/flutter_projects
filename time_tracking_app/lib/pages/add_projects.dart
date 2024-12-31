import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/models/project.dart';
import 'package:time_tracking_app/providers/time_entry_provider.dart';

class AddProjects extends StatefulWidget {
  const AddProjects({super.key});

  @override
  State<AddProjects> createState() => _AddProjectsState();
}

class _AddProjectsState extends State<AddProjects> {
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
        title: const Text("Projects"),
      ),
      body: ListView.builder(
        itemCount: Provider.of<TimeEntryProvider>(context).projects.length,
        itemBuilder: (context, index) {
          final project = Provider.of<TimeEntryProvider>(context).projects[index];
          return ListTile(
            title: Text(project.name),
            trailing: IconButton(
              onPressed: () {
                Provider.of<TimeEntryProvider>(context, listen: false)
                    .deleteSingle(entityType: "projects", entity: project);
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
              title: const Text("Add Project"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter Project Name",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Provider.of<TimeEntryProvider>(context, listen: false)
                          .addOrUpdate(
                       entity:  Project(
                          name: _nameController.text,
                          id: DateTime.timestamp().toString(), // Replace with appropriate ID generation if needed
                        ),entityType: "projects"
                      );
                  _nameController.text="";
                      Navigator.pop(context); // Close the dialog after adding
                    },
                    child: const Text("Add Project"),
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