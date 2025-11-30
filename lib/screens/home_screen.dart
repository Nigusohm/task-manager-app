import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_title.dart';
import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return TaskTile(
                    task: task,
                    onToggle: () {
                      taskProvider.toggleTaskStatus(index);
                    },
                    onDelete: () {
                      taskProvider.removeTask(index);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Add New Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(hintText: 'Task Title'),
                        ),
                        TextField(
                          controller: _descController,
                          decoration: InputDecoration(hintText: 'Description'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final title = _titleController.text.trim();
                          final desc = _descController.text.trim();
                          if (title.isNotEmpty) {
                            taskProvider.addTask(Task(
                              title: title,
                              description: desc,
                            ));
                          }
                          _titleController.clear();
                          _descController.clear();
                          Navigator.pop(context);
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
