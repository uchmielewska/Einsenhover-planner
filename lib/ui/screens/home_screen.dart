import 'package:eisenhover_planner/ui/screens/add_task_screen.dart';
import 'package:eisenhover_planner/ui/screens/plan_day_screen.dart';
import 'package:eisenhover_planner/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../services/theme_services.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(children: [_addTaskBar()]),
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
              onTap: () => Get.to(const AddTaskPage())),
          SpeedDialChild(
              child: const Icon(Icons.list_alt),
              label: 'Planuj dzień',
              onTap: () => Get.to(const MyPlanDayPage()))
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
