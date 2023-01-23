import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/add_task/add_task_cubit.dart';
import '../../business_logic/cubit/task/task_cubit.dart';
import '../../data/data_providers/task_api.dart';
import '../../data/repositories/task_repository.dart';
import '../screens/add_task_screen.dart';
import '../screens/home_screen.dart';
import '../screens/plan_day_screen.dart';
import 'routes.dart';

class AppRouter {
  //repos
  late TaskRepository _taskRepository;

  // cubits
  late TaskCubit _taskCubit;

  AppRouter() {
    _taskRepository = TaskRepository(TaskAPI());

    _taskCubit = TaskCubit(_taskRepository);
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case planDayRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _taskCubit,
                  child: const PlanDayScreen(),
                ));
      case addTaskRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      AddTaskCubit(_taskRepository, _taskCubit),
                  child: const AddTaskScreen(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _taskCubit,
                  child: const HomeScreen(),
                ));
    }
  }
}
