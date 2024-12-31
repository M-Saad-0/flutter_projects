
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/models/task.dart';
import 'package:time_tracking_app/providers/time_entry_provider.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
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
        title: const Text("Tasks"),
      ),
      body: ListView.builder(
          itemCount: Provider.of<TimeEntryProvider>(context).tasks.length,
          itemBuilder: (context, index) {
            final task =
                Provider.of<TimeEntryProvider>(context).tasks[index];
            return ListTile(
              title: Text(task.name),
              trailing: IconButton(
                  onPressed: () {
                    Provider.of<TimeEntryProvider>(context, listen: false)
                        .deleteSingle(entityType: "tasks", entity: task);
                  },
                  icon: const Icon(Icons.delete)),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Add Task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: "Enter Task Name"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Provider.of<TimeEntryProvider>(context, listen: false).addOrUpdate(
                                entity: Task(
                                    name: _nameController.text,
                                    id: DateTime.timestamp().toString()), entityType: "tasks");
                                    _nameController.text="";
                                    Navigator.pop(context);
                          },
                          child: const Text("Add Task"))
                    ],
                  ),
                ));
      },child: Icon(Icons.add),),
    );
  }
}
