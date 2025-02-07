/*

Modèle de tâches

Une tâche doit avoir:
- id
- uid
- name
- date
- status

*/

import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  final String id;
  final String uid;
  final String taskname;
  final Timestamp timestamp;

  Task({
    required this.id,
    required this.uid,
    required this.taskname,
    required this.timestamp,
  });

  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      uid: doc['uid'],
      taskname: doc['taskname'],
      timestamp: doc['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'uid': uid,
      'taskname': taskname,
      'timestamp': timestamp,
    };
  }
}