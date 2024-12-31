import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/pages/add_projects.dart';
import 'package:time_tracking_app/pages/add_tasks.dart';
import 'package:time_tracking_app/pages/add_time_entry.dart';
import 'package:time_tracking_app/providers/time_entry_provider.dart';

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
              child: Center(
                child: Text("Menu",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTasks()));
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.edit_document),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Manage Tasks",
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                )),
            const Divider(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProjects()));
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.folder),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Manage Projects"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ))
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Your Time Entries"),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              text: "All Entries",
            ),
            Tab(
              text: "By Project",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          // Tab 1: Expenses by Date
          Consumer<TimeEntryProvider>(
            builder: (context, provider, child) => provider.timeEntries.isEmpty
                ? const Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty,
                            color: Color.fromARGB(255, 146, 146, 146)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No time entries yet.",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 102, 101, 101)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Press + to add time entries",
                          style: TextStyle(
                              color: Color.fromARGB(255, 146, 146, 146)),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.timeEntries.length,
                    itemBuilder: (context, index) {
                      final expense = provider.timeEntries[index];
                      print(expense.projectId);
                      return Dismissible(
                        key: Key(expense.id.toString()),
                              direction: DismissDirection.endToStart, // Swipe left to delete
                        onDismissed: (direction){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Entry with note ${expense.notes} deleted.")));
                          provider.deleteSingle(entityType: "timeEntries", entity: expense);

                        },
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.timer),
                          ),
                          title: Text(
                            "${expense.notes}  -  ${expense.totalTime} hours",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            "${DateFormat('yyyy-MM-dd').format(expense.date)} - ${provider.tasks[provider.tasks.indexWhere((e) => e.id == expense.taskId)].name} - ${provider.projects[provider.projects.indexWhere((e) => e.id == expense.projectId)].name}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Tab 2: Expenses by Category
          Consumer<TimeEntryProvider>(
            builder: (context, provider, child) {
              if (provider.timeEntries.isEmpty) {
                return const Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty,
                            color: Color.fromARGB(255, 146, 146, 146)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No time entries yet.",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 102, 101, 101)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Press + to add time entries",
                          style: TextStyle(
                              color: Color.fromARGB(255, 146, 146, 146)),
                        )
                      ],
                    ),
                  );
              }

              return ListView.builder(
                itemCount: provider.projects.length,
                itemBuilder: (context, index) {
                  final project = provider.projects[index];
                  final timeEntryByProject = provider.timeEntries
                      .where((entry) => entry.projectId == project.id)
                      .toList();

                  if (timeEntryByProject.isEmpty) {
                    return const SizedBox();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          project.name,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...timeEntryByProject.map((entry) {
                        final taskName = provider.tasks
                            .firstWhere((task) => task.id == entry.taskId)
                            .name;

                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.timer),
                          ),
                          title: Text(
                                                      "${entry.notes}  -  ${entry.totalTime} hours",

                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            "Task: $taskName",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTimeEntry()));
          },
          child: const Icon(Icons.add)),
    );
  }
}
