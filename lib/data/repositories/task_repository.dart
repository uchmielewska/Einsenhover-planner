import 'package:uuid/uuid.dart';

import '../data_providers/task_api.dart';
import '../models/task.dart';
import '../../business_logic/cubit/task/task_cubit.dart';

class TaskRepository {
  final TaskAPI api;

  TaskRepository(this.api);

  Future<List<Task>> fetchTasks() async {
    try {
      final rawTasks = await api.fetchRawTasks();

      List<Task> tasks = List<Task>.from(rawTasks['data'].map((value) {
        return Task(
            id: value['id'],
            title: value['title'],
            description: value['description'],
            isFinished: value['isFinished'],
            isImportant: value['isImportant'],
            isPrior: value['isPrior'],
            isChosen: value['isChosen']);
      }));

      return tasks;
    } catch (e) {
      return [];
    }
  }

  Future<Task> addTask(
      String title, String description, bool isImportant, bool isPrior) async {
    try {
      const uuid = Uuid();

      List<Task> tasks = await fetchTasks();
      Task newTask = Task(
          id: uuid.v1(),
          title: title,
          description: description,
          isImportant: isImportant,
          isPrior: isPrior,
          isFinished: false,
          isChosen: false);

      tasks.add(newTask);

      final rawTasks = _prepareTasksForApi(tasks);

      await api.saveTasks(rawTasks);
      return newTask;
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> toggleIsTaskChosen(String id, bool chosen) async {
    try {
      List<Task> tasks = await fetchTasks();

      int index = tasks.indexWhere((task) => task.id == id);

      tasks[index].isChosen = chosen;

      final rawTasks = _prepareTasksForApi(tasks);

      await api.saveTasks(rawTasks);

      return tasks[index];
    } catch (e) {
      rethrow;
    }
  }

  Future<Task> toggleIsTaskFinished(String id, bool finished) async {
    try {
      List<Task> tasks = await fetchTasks();

      int index = tasks.indexWhere((task) => task.id == id);

      tasks[index].isFinished = finished;

      final rawTasks = _prepareTasksForApi(tasks);

      await api.saveTasks(rawTasks);

      return tasks[index];
    } catch (e) {
      rethrow;
    }
  }

  Map<String, Object?> _prepareTasksForApi(List<Task> tasks) {
    return Map<String, Object?>.from(
        {"data": tasks.map((t) => t.toJson()).toList()});
  }

  void emit(TaskLoaded taskLoaded) {}
}
