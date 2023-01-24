import 'package:eisenhover_planner/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../business_logic/cubit/task/task_cubit.dart';
import '../../services/theme_services.dart';
import '../widgets/bottom_nagivation.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).fetchTasks();

    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: const BottomNavigationWidget(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _addTaskBar(),
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

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingStyle),
          Text("Dziś",
              style: headingStyle,
              selectionColor: Get.isDarkMode ? Colors.white : Colors.black),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      // backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: const Icon(Icons.nightlight_round, size: 20),
      ),
    );
  }
}
