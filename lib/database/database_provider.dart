import 'package:flutter/foundation.dart';
import 'package:taskify_project/models/task.dart';
import '../models/user.dart';
import 'database_service.dart';

/*

Database provider

Sert à séparer la gestion des données Firestore de la manière dont elles sont affichées sur l'UI

- le database service s'occupe de gérer les données de bdd
- le database provider organise et affiche les données

Ce permet de rendre le code plus adaptable, facile à tester, propre et sûr.

*/

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);


/*

TACHES

*/

// Lister les tâches locales
  List<Task> _allTasks = [];

// récupère toutes les tâches en local
  List<Task> get allTasks => _allTasks;

// récupère les tâches depuis Firebase
  Future<void> loadAllTasks() async {
    final allTasks = await _db.getAllTasksFromFirebase();

    _allTasks = allTasks;

    // Maj de l'UI
    notifyListeners();
  }

// Filtrer et récupèrer les tâches d'un utilisateurs
  List<Task> filterUserTasks(String uid) {
    return _allTasks.where((task) => task.uid == uid).toList();
  }

// Ajouter une tâche
  Future<void> taskName(String taskname) async {
    // on ajoute la tâche sur Firebase
    await _db.taskNameInFirebase(taskname);

    // on recharge les données depuis Firebase
    loadAllTasks();
  }

// supprimer un message
  Future<void> deleteTask(String taskId) async {
    await _db.deleteTaskFromFirebase(taskId);

    await loadAllTasks();
  }

}