import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:time_tracking_app/models/project.dart';
import 'package:time_tracking_app/models/task.dart';
import 'package:time_tracking_app/models/time_entry.dart';

class TimeEntryProvider with ChangeNotifier {
  List<TimeEntry> _timeEntries = [];
  List<Task> _tasks = [];
  List<Project> _projects = [];

  List<TimeEntry> get timeEntries => _timeEntries;
  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;

  TimeEntryProvider() {
    _loadAllEntries();
  }

  void _loadAllEntries() {
  final storedTimeEntries = localStorage.getItem("timeEntries");
  final storedTasks = localStorage.getItem("tasks");
  final storedProjects = localStorage.getItem("projects");

  if (storedTimeEntries != null) {
    _timeEntries = (jsonDecode(storedTimeEntries) as List)
        .map((e) => TimeEntry.fromJson(e))
        .toList();
    notifyListeners();
  }
  if (storedTasks != null) {
    _tasks = (jsonDecode(storedTasks) as List)
        .map((e) => Task.fromJson(e))
        .toList();
    notifyListeners();
  }
  if (storedProjects != null) {
    _projects = (jsonDecode(storedProjects) as List)
        .map((e) => Project.fromJson(e))
        .toList();
    notifyListeners();
  }
}

void _saveAll(String entityType) {
  if (entityType == "timeEntries") {
    localStorage.setItem(
        entityType, jsonEncode(_timeEntries.map((e) => e.toJson()).toList()));
  } else if (entityType == "tasks") {
    localStorage.setItem(
        entityType, jsonEncode(_tasks.map((e) => e.toJson()).toList()));
  } else {
    localStorage.setItem(
        entityType, jsonEncode(_projects.map((e) => e.toJson()).toList()));
  }
}

  void emptyAll(){
    _projects=[];
    _timeEntries=[];
    _tasks=[];
    _saveAll("timeEntries");
    _saveAll("tasks");
    _saveAll("projects");
  }

  void addOrUpdate({required String entityType, required dynamic entity}) {
    if (entityType == 'timeEntries') {
      TimeEntry timeEntry = entity as TimeEntry;
      int index = _timeEntries.indexWhere((e) => e.id == timeEntry.id);
      if (index == -1) {
        _timeEntries.add(timeEntry);
        _saveAll(entityType);
      } else {
        _timeEntries[index] = timeEntry;
        _saveAll(entityType);
      }
    } else if (entityType == 'tasks') {
      Task task = entity as Task;
      int index = _tasks.indexWhere((e) => e.id == task.id);
      if (index == -1) {
        _tasks.add(task);
        _saveAll(entityType);
      } else {
        _tasks[index] = task;
        _saveAll(entityType);
      }
    } else {
      Project project = entity as Project;
      int index = _projects.indexWhere((e) => e.id == project.id);
      if (index == -1) {
        _projects.add(project);
        _saveAll(entityType);
      } else {
        _projects[index] = project;
        _saveAll(entityType);
      }
    }
    notifyListeners();
  }

  void deleteAll(String entityType){
    localStorage.removeItem(entityType);
    notifyListeners();
  }

  void deleteSingle({required String entityType, dynamic entity}) {
    if (entityType == 'timeEntries') {
      TimeEntry timeEntry = entity as TimeEntry;
      _timeEntries.removeWhere((e)=>e.id==timeEntry.id);
    } else if (entityType == 'tasks') {
      Task task = entity as Task;
      _tasks.removeWhere((e)=>e.id==task.id);
      
    } else {
      Project project = entity as Project;
      _projects.removeWhere((e)=>e.id==project.id);
    }
    _saveAll(entityType);
    notifyListeners();
  }
  
}
