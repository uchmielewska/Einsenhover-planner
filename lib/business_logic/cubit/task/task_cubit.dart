import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository taskRepository;

  TaskCubit(this.taskRepository) : super(TaskInitial());

  void fetchTasks() {
    taskRepository.fetchTasks().then((tasks) => {emit(TaskLoaded(tasks))});
  }

  addTask(Task task) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final tasks = currentState.tasks;
      tasks.add(task);

      List<Task> importantPrior =
          tasks.where((t) => t.isPrior && t.isImportant).toList();
      List<Task> importantNotPrior =
          tasks.where((t) => !t.isPrior && t.isImportant).toList();
      List<Task> notImportantPrior =
          tasks.where((t) => t.isPrior && !t.isImportant).toList();
      List<Task> notImportantNotPrior =
          tasks.where((t) => !t.isPrior && !t.isImportant).toList();

      List<Task> sortedTasks = importantPrior +
          notImportantPrior +
          importantNotPrior +
          notImportantNotPrior;

      emit(TaskLoaded(sortedTasks));
    }
  }

  toggleIsTaskChosen(String id, bool chosen) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final tasks = currentState.tasks;
      final index = tasks.indexWhere((t) => t.id == id);

      if (index != -1) {
        emit(TaskLoading());
        taskRepository.toggleIsTaskChosen(id, chosen).then((task) => emit(
            TaskLoaded(tasks.map((t) => t.id == task.id ? task : t).toList())));
        taskRepository.emit(TaskLoaded(tasks));
      }
    }
  }

  toggleIsTaskFinished(String id, bool finished) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final tasks = currentState.tasks;
      final index = tasks.indexWhere((t) => t.id == id);

      if (index != -1) {
        emit(TaskLoading());
        taskRepository.toggleIsTaskFinished(id, finished).then((task) => emit(
            TaskLoaded(tasks.map((t) => t.id == task.id ? task : t).toList())));
        taskRepository.emit(TaskLoaded(tasks));
      }
    }
  }
}
