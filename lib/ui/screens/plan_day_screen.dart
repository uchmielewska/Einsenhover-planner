import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../business_logic/cubit/task/task_cubit.dart';
import '../theme.dart';
import '../widgets/task_tile.dart';

class PlanDayScreen extends StatefulWidget {
  const PlanDayScreen({super.key});

  @override
  State<PlanDayScreen> createState() => _PlanDayState();
}

class _PlanDayState extends State<PlanDayScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchTasks();

    return Scaffold(
      appBar: _appBar(context),
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

                  if (state.tasks.isEmpty) {
                    return Center(
                        child: Text("Brak wybranych zadań na dziś",
                            style: infoHeadingStyle));
                  }

                  return ListView(
                    children: ListTile.divideTiles(
                        context: context,
                        tiles: state.tasks.map((task) {
                          return task.isChosen
                              ? MyTaskTile(
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

  _planDayBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Twoje zadania",
              style: headingStyle,
              selectionColor: Get.isDarkMode ? Colors.white : Colors.black),
        ],
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back_ios, size: 20),
      ),
    );
  }
}
