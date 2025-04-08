import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final tasksRef = FirebaseFirestore.instance.collection('tasks');

  // Add a new task to Firestore
  Future<void> _addTask(String taskName) async {
    if (taskName.trim().isEmpty) return;
    await tasksRef.add({
      'name': taskName,
      'completed': false,
      'userId': userId,
      'createdAt': Timestamp.now(),
      'subtasks': [],
    });
    _taskController.clear();
  }

  Future<void> _toggleComplete(DocumentSnapshot taskDoc) async {
    await taskDoc.reference.update({'completed': !(taskDoc['completed'] as bool)});
  }

  Future<void> _deleteTask(DocumentSnapshot taskDoc) async {
    await taskDoc.reference.delete();
  }

  Future<void> _addSubtask(DocumentSnapshot taskDoc, String day, String timeSlot, String detail) async {
    final subtasks = List<Map<String, dynamic>>.from(taskDoc['subtasks'] ?? []);
    subtasks.add({'day': day, 'timeSlot': timeSlot, 'detail': detail});
    await taskDoc.reference.update({'subtasks': subtasks});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📝 Task Manager')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: 'Enter a task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTask(_taskController.text),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: tasksRef
                  .where('userId', isEqualTo: userId)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final tasks = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return Card(
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Checkbox(
                              value: task['completed'],
                              onChanged: (_) => _toggleComplete(task),
                            ),
                            Expanded(child: Text(task['name'])),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(task),
                            ),
                          ],
                        ),
                        children: [
                          ...(task['subtasks'] as List<dynamic>? ?? []).map((sub) {
                            return ListTile(
                              title: Text("${sub['day']} ${sub['timeSlot']}"),
                              subtitle: Text(sub['detail']),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => _AddSubtaskDialog(
                                    onSave: (day, time, detail) =>
                                        _addSubtask(task, day, time, detail),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Subtask'),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// Dialog to add a subtask
class _AddSubtaskDialog extends StatefulWidget {
  final void Function(String day, String timeSlot, String detail) onSave;

  const _AddSubtaskDialog({required this.onSave});

  @override
  State<_AddSubtaskDialog> createState() => _AddSubtaskDialogState();
}

class _AddSubtaskDialogState extends State<_AddSubtaskDialog> {
  final _dayController = TextEditingController();
  final _timeController = TextEditingController();
  final _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Subtask"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _dayController, decoration: const InputDecoration(hintText: 'Day (e.g., Monday)')),
          TextField(controller: _timeController, decoration: const InputDecoration(hintText: 'Time Slot (e.g., 9AM-10AM)')),
          TextField(controller: _detailController, decoration: const InputDecoration(hintText: 'Task Detail')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSave(
              _dayController.text.trim(),
              _timeController.text.trim(),
              _detailController.text.trim(),
            );
            Navigator.pop(context);
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
