part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskError extends AddTaskState {
  final String error;

  AddTaskError(this.error);
}

class AddTaskLoading extends AddTaskState {}

class TaskAdded extends AddTaskState {}
