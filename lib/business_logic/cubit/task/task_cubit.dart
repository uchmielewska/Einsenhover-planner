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

      List<Task> sortedTasks = tasks;
      sortedTasks.sort((Task task1, Task task2) {
        if (task2.isImportant && task2.isPrior) {
          return 2;
        } else if (task2.isImportant && !task2.isPrior) {
          return 1;
        } else if (!task2.isImportant && task2.isPrior) {
          return 0;
        }
        return -1;
      });

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
        // categoryRepository.emit(CategoryLoaded(categories));
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
        // categoryRepository.emit(CategoryLoaded(categories));
      }
    }
  }
}
