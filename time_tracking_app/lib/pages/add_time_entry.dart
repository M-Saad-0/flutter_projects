import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/models/time_entry.dart';
import 'package:time_tracking_app/providers/time_entry_provider.dart';

class AddTimeEntry extends StatefulWidget {
  const AddTimeEntry({super.key});

  @override
  State<AddTimeEntry> createState() => _AddTimeEntryState();
}

class _AddTimeEntryState extends State<AddTimeEntry> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? _selectedTaskId;
  String? _selectedProjectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Your Time Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Task"),
              DropdownButton<String>(
                value: _selectedTaskId,
                hint: const Text("Select Task"),
                onChanged: (value) {
                  setState(() {
                    _selectedTaskId = value;
                    _taskController.text = value ?? "";
                  });
                },
                items: Provider.of<TimeEntryProvider>(context)
                    .tasks
                    .map((task) => DropdownMenuItem(
                          value: task.id,
                          child: Text(task.name),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text("Project"),
              DropdownButton<String>(
                value: _selectedProjectId,
                hint: const Text("Select Project"),
                onChanged: (value) {
                  setState(() {
                    _selectedProjectId = value;
                    _projectController.text = value ?? "";
                  });
                },
                items: Provider.of<TimeEntryProvider>(context)
                    .projects
                    .map((project) => DropdownMenuItem(
                          value: project.id,
                          child: Text(project.name),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text("Hours"),
              TextField(
                controller: _hoursController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter hours",
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
                    icon: const Icon(Icons.date_range),
                  ),
                  hintText: "Select a date",
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final taskId = _taskController.text;
                    final projectId = _projectController.text;
                    final hours = _hoursController.text;
                    final note = _noteController.text;

                    if (taskId.isEmpty || projectId.isEmpty || hours.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all required fields."),
                        ),
                      );
                    } else {
                      final timeEntry = TimeEntry(
                        id: DateTime.now().toIso8601String(),
                        taskId: taskId,
                        projectId: projectId,
                        notes: note,
                        totalTime: double.parse(hours),
                        date: DateTime.parse(_dateController.text),
                      );

                      Provider.of<TimeEntryProvider>(context, listen: false)
                          .addOrUpdate(entityType: "timeEntries", entity: timeEntry);
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Time entry added successfully!")),
                      );
                    }
                  },
                  child: const Text("Submit Time Entry"),
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

  @override
  void dispose() {
    _taskController.dispose();
    _hoursController.dispose();
    _noteController.dispose();
    _projectController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
