import 'package:flutter/material.dart';
import 'package:remind/services/taskList.dart';
import 'package:remind/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//import 'task_model.dart'; // Import the Task model.

class TasklistProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TasklistProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> taskList = jsonDecode(tasksString);
      _tasks = taskList.map((taskMap) => Task.fromMap(taskMap)).toList();
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> taskList =
        _tasks.map((task) => task.toMap()).toList();
    await prefs.setString('tasks', jsonEncode(taskList));
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void clearTasks() {
    tasks.clear();
    notifyListeners();
  }
}
