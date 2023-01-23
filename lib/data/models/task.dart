import 'dart:ffi';

class Task {
  String id;
  String title;
  String description;
  bool isFinished;
  bool isImportant;
  bool isPrior;
  bool isChosen;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.isFinished,
      required this.isImportant,
      required this.isPrior,
      required this.isChosen});

  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isFinished': isFinished,
        'isImportant': isImportant,
        'isPrior': isPrior,
        'isChosen': isChosen
      };
}
