import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/repositories/task_repository.dart';
import '../task/task_cubit.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskRepository taskRepository;
  final TaskCubit taskCubit;

  AddTaskCubit(this.taskRepository, this.taskCubit) : super(AddTaskInitial());

  addTask(String title, String description, bool isImportant, bool isPrior) {
    emit(AddTaskLoading());

    taskRepository
        .addTask(title, description, isImportant, isPrior)
        .then((task) {
      taskCubit.addTask(task);
      emit(TaskAdded());
    });
  }
}
