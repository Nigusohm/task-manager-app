import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskStatus(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
