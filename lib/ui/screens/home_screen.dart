import 'package:eisenhover_planner/ui/screens/add_task_screen.dart';
import 'package:eisenhover_planner/ui/screens/plan_day_screen.dart';
import 'package:eisenhover_planner/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../business_logic/cubit/task/task_cubit.dart';
import '../../services/theme_services.dart';
import '../widgets/button.dart';
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _addTaskBar(),
          BlocBuilder<TaskCubit, TaskState>(
            builder: (blocContext, state) {
              if (state is! TaskLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              return Text(state.tasks[0].title);
              // return ListView(
              //   children: ListTile.divideTiles(
              //       context: context,
              //       tiles: state.tasks.map((task) {
              //         return MyTaskTile(
              //           id: task.id,
              //           title: task.title,
              //         );
              //       })).toList(),
              // );
            },
          ),
        ]),
        floatingActionButton: _floatingMenuButton());
  }

  _floatingMenuButton() {
    return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        spacing: 12,
        spaceBetweenChildren: 12,
        backgroundColor: primaryClr,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'Dodaj zadanie',
              onTap: () => Get.to(const AddTaskScreen())),
          SpeedDialChild(
              child: const Icon(Icons.list_alt),
              label: 'Planuj dzień',
              onTap: () => Get.to(const PlanDayScreen()))
        ]);
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
              selectionColor: Get.isDarkMode ? Colors.white : Colors.black)
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
        actions: const [
          Icon(Icons.person, size: 20),
          SizedBox(width: 20),
        ]);
  }
}
