import 'package:flutter/material.dart';
import 'package:taskify_project/models/task.dart';

import '../pages/task_page.dart';

void goTaskPage(BuildContext context, Task task) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TaskPage(
      task: task,
    ),
    ),
  );
}