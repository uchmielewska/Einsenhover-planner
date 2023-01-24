import 'package:flutter/material.dart';

class TaskTilePlanning extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final bool isFinished;
  final bool isImportant;
  final bool isPrior;
  final bool isChosen;

  const TaskTilePlanning({
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
    return TextButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
            color: isImportant
                ? isPrior
                    ? Colors.red[400]
                    : Colors.orange[600]
                : isPrior
                    ? Colors.yellow[600]
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
            isChosen
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 32)
                : const Text(''),
          ],
        ),
      ),
    );
  }
}
