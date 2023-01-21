import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_users.dart';

class TaskAPI {
  Future<dynamic> fetchRawTasks() async {
    return FirebaseFirestore.instance
        .collection('tasks')
        .doc(userId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
  }

  Future<void> saveTasks(Map<String, Object?> data) async {
    return FirebaseFirestore.instance
        .collection('tasks')
        .doc(userId)
        .update(data);
  }
}
