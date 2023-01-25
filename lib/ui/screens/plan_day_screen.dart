import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../business_logic/cubit/task/task_cubit.dart';
import '../../data/models/task.dart';
import '../../services/theme_services.dart';
import '../theme.dart';
import '../widgets/bottom_nagivation.dart';
import '../widgets/task_tile_planning.dart';

class PlanDayScreen extends StatefulWidget {
  const PlanDayScreen({super.key});

  @override
  State<PlanDayScreen> createState() => _PlanDayState();
}

class _PlanDayState extends State<PlanDayScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchTasks();

    int countNotFinishedTasks(List<Task> tasks) {
      int count = 0;
      for (var task in tasks) {
        if (!task.isFinished) {
          count++;
        }
      }
      print(count);
      return count;
    }

    return Scaffold(
      appBar: _appBar(),
      // ignore: prefer_const_constructors
      bottomNavigationBar: BottomNavigationWidget(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _planDayBar(),
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (blocContext, state) {
                  if (state is! TaskLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<Task> sortedTasks = state.tasks;
                  // sortedTasks.sort((Task task1, Task task2) {
                  //   if (task2.isImportant && task2.isPrior) {
                  //     return 2;
                  //   } else if (task2.isImportant && !task2.isPrior) {
                  //     return 1;
                  //   } else if (!task2.isImportant && task2.isPrior) {
                  //     return 0;
                  //   }
                  //   return -1;
                  // });

                  if (countNotFinishedTasks(sortedTasks) == 0) {
                    return Center(
                        child: Text("Brak zadań", style: infoHeadingStyle));
                  }

                  return ListView(
                    children: ListTile.divideTiles(
                        context: context,
                        tiles: sortedTasks.map((task) {
                          return !task.isFinished
                              ? TaskTilePlanning(
                                  id: task.id,
                                  title: task.title,
                                  description: task.description,
                                  isFinished: task.isFinished,
                                  isImportant: task.isImportant,
                                  isPrior: task.isPrior,
                                  isChosen: task.isChosen,
                                )
                              : const SizedBox.shrink();
                        })).toList(),
                  );
                },
              ),
            )
          ]),
    );
  }

  // _sortTasks(Task task1, Task task2) {
  //   var comparisonResult = task1.surname.compareTo(task2.surname);
  //   if (comparisonResult != 0) {
  //     return comparisonResult;
  //   }
  //   // Surnames are the same, so subsort by given name.
  //   return name1.givenName.compareTo(name2.givenName);
  // }

  _planDayBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Planuj dzień",
              style: headingStyle,
              selectionColor: Get.isDarkMode ? Colors.white : Colors.black),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: const Icon(Icons.nightlight_round, size: 20),
      ),
    );
  }
}
