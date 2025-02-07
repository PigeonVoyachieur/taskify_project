import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify_project/database/database_provider.dart';
import 'package:taskify_project/models/task.dart';

/*

Page d'une tâches en particulier avec son statut et son nom

*/

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({
    super.key,
    required this.task
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}


class _TaskPageState extends State<TaskPage> {
  // Provider
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: [
        ],
      ),
    );
  }
}
