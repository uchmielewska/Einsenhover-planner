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
      emit(TaskLoaded(tasks));
    }
  }
}
