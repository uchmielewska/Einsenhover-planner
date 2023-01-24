import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/add_task/add_task_cubit.dart';
import '../../services/theme_services.dart';
import '../widgets/add_task_form.dart';
import '../widgets/bottom_nagivation.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: const BottomNavigationWidget(),
        body: BlocListener<AddTaskCubit, AddTaskState>(
          listener: (ctx, state) {
            if (state is TaskAdded) {
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: const AddTaskForm(),
          ),
        ),
        resizeToAvoidBottomInset: false);
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
