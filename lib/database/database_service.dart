/*

Service qui va gérere toutes les données vers et depuis Firestore

-------------------------------------------------------

- utilisateurs
- Tâches

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify_project/models/task.dart';
import '../models/user.dart';

class DatabaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

/*
UTILISATEURS
*/

  Future<void> saveUserInfoInFirebase({required String name, email}) async {
    String uid = _auth.currentUser!.uid;

    UserProfile user = UserProfile(uid: uid,
        name: name,
        email: email,
    );

    final userMap = user.toMap();

    await _db.collection('Users').doc(uid).set(userMap);
  }

  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try{
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch(e){
      print(e);
      return null;
    }
  }

/*
TACHES
*/

  Future<void> taskNameInFirebase(String taskname) async {
    try {

      String uid = _auth.currentUser!.uid;
      UserProfile? user = await getUserFromFirebase(uid);

      Task newTask = Task(
        id: '',
        uid: uid,
        taskname: taskname,
        timestamp: Timestamp.now(),
      );

      Map<String, dynamic> newTaskMap = newTask.toMap();
      await _db.collection("Tasks").add(newTaskMap);
    } catch(e) {
      print(e);
    }
  }

  Future<void> deleteTaskFromFirebase(String taskId) async {
    try {
      await _db.collection('Tasks').doc(taskId).delete();
    } catch(e) {
      print(e);
    }
  }

  Future<List<Task>> getAllTasksFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection("Tasks")
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
    } catch(e) {
      return [];
    }
  }

}