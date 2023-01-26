import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/task/task_cubit.dart';
import '../theme.dart';

class MyTaskTile extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final bool isFinished;
  final bool isImportant;
  final bool isPrior;
  final bool isChosen;

  const MyTaskTile({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.isFinished,
    required this.isImportant,
    required this.isPrior,
    required this.isChosen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _taskStatus = ["w trakcie", "zakończone"];

    return TextButton(
      onPressed: () {
        // BlocProvider.of<TaskCubit>(context)
        //     .toggleIsTaskFinished(id, !isFinished);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
            color: isImportant
                ? isPrior
                    ? Colors.red[400]
                    : Colors.yellow[600]
                : isPrior
                    ? Colors.orange[600]
                    : Colors.green[400],
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Text(description, style: const TextStyle(color: Colors.white))
              ],
            ),
            DropdownButton(
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              iconSize: 24,
              elevation: 4,
              style: inputTitleStyle,
              underline: Container(height: 0),
              onChanged: (String? newValue) {
                if (newValue == 'zakończone') {
                  BlocProvider.of<TaskCubit>(context)
                      .toggleIsTaskFinished(id, !isFinished);
                }
              },
              items: _taskStatus.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
