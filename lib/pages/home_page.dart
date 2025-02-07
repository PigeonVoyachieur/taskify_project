import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify_project/database/database_provider.dart';
import '../components/my_drawer.dart';
import '../components/my_input_alertbox.dart';
import '../components/my_task_tile.dart';
import '../helper/navigate_pages.dart';
import '../models/task.dart';

/*

Home Page

*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Provider
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  // Controller
  final _messageController = TextEditingController();

  // Au démarrage

  // Boite de dialogue pour créer une nouvelle tâches
  void _openNewTaskMessageBox() {
    showDialog(
      context: (context),
      builder: (context) => MyInputAlertbox(
          textController: _messageController,
          hintText: "Ajoutez une tâches",
          onPressed: () async {
            await newTask(_messageController.text);
          },
          onPressedText: "Ajouter"
      ),
    );
  }

  // Afficher la nouvelle tâches sur la page d'acceuil
  Future<void> newTask(String taskname) async {
    await databaseProvider.taskName(taskname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Acceuil"
        ),
      ),
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewTaskMessageBox,
        child: const Icon(Icons.add),
      ),

      // Liste des tâches
      body: _buildTaskList(listeningProvider.allTasks),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    return tasks.isEmpty
        ?
    Center(
      child: Text(
          'Vous n\'avez pas de tâches pour le moment'
      ),
    )
        :
    ListView.builder(itemBuilder: (context, index) {
      final task = tasks[index];
      return MyTaskTile(
        task: task,
        onTaskTap: () => goTaskPage(context, task),
      );
    });
  }
}
