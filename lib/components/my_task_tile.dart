import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify_project/database/database_provider.dart';
import 'package:taskify_project/models/task.dart';
import '../services/auth/auth_service.dart';

/*

Task Tile = une case pour chaque tâches

-----------------------------------------------------

Pour chaque tile il faut:
-une tâche
-une fonction pour rediriger sur la tâche quand on clique dessus

*/

class MyTaskTile extends StatefulWidget {
  final Task task;
  final void Function()? onTaskTap;

  const MyTaskTile({
    super.key,
    required this.task,
    required this.onTaskTap,
  });

  @override
  State<MyTaskTile> createState() => _MyTaskTileState();
}

class _MyTaskTileState extends State<MyTaskTile> {
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);

  // Méthode pour afficher les options d'une tâches
  void _showOptions() {
    String CurrentUid = AuthService().getCurrentUid();
    final bool isOwnTask = widget.task.uid == CurrentUid;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                if (isOwnTask)
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Supprimer"),
                    onTap: () async {
                      Navigator.pop(context);
                      await databaseProvider.deleteTask(widget.task.id);
                    },
                  )
                else
                  ...[],

                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Annuler"),
                  onTap: () async {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTaskTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .colorScheme
              .secondary,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                  ),

                  const SizedBox(width: 10,),

                  const SizedBox(width: 4,),

                  Spacer(),

                  GestureDetector(
                    onTap: _showOptions,
                    child: Icon(
                      Icons.more_horiz,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              widget.task.taskname,
              style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
            ),

            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
