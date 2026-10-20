import 'package:flutter/material.dart';
import 'package:todo_app/models/tasks.dart';
import 'package:todo_app/widgets/task_tile.dart';
import 'package:todo_app/widgets/edit_task_dialog.dart';
import 'package:todo_app/services/task_storage.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TaskStorage _storage = TaskStorage();
  List<Task> _tasks = [];
  bool _isLoading = true;
  final TextEditingController _taskController = TextEditingController();

  // The AppBar counter is derived from the current task state.
  int get _tasksLeft => _tasks.where((task) => !task.isDone).length;

  bool get _hasCompletedTasks => _tasks.any((task) => task.isDone);

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loaded = await _storage.load();
    if (!mounted) return;
    setState(() {
      _tasks = loaded;
      _isLoading = false;
    });
  }

  void _update(VoidCallback change) {
    setState(change);
    _storage.save(_tasks);
  }

  void _addTask() {
    final text = _taskController.text.trim();
    if (text.isEmpty) return;

    _update(() => _tasks.add(Task(text)));
    _taskController.clear();
  }

  void _toggleTask(int index) {
    _update(() => _tasks[index].isDone = !_tasks[index].isDone);
  }

  // Long-press priority changes use the same setState-and-save path as other edits.
  void _toggleImportant(int index) {
    _update(() => _tasks[index].isImportant = !_tasks[index].isImportant);
  }

  // The AppBar action clears all completed tasks in one state update.
  void _clearCompletedTasks() {
    _update(() => _tasks.removeWhere((task) => task.isDone));
  }

  // Both the delete button and swipe gesture require explicit confirmation.
  Future<bool> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return mounted && (confirmed ?? false);
  }

  // Undo restores the removed task at its original list position.
  void _deleteTask(Task task) {
    final index = _tasks.indexOf(task);
    if (index == -1) return;

    _update(() => _tasks.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            final insertionIndex = index.clamp(0, _tasks.length);
            _update(() => _tasks.insert(insertionIndex, task));
          },
        ),
      ),
    );
  }

  Future<void> _editTask(int index) async {
    final newTitle = (await showEditTaskDialog(
      context,
      _tasks[index].title,
    ))?.trim();
    if (newTitle == null || newTitle.isEmpty) return;
    _update(() => _tasks[index].title = newTitle);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks ($_tasksLeft left)'),
        actions: [
          IconButton(
            tooltip: 'Clear completed',
            onPressed: _hasCompletedTasks ? _clearCompletedTasks : null,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _taskController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a task',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => _addTask(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: _addTask,
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _tasks.isEmpty
                      ? const Center(
                          child: Text('No tasks yet! Add one above.'),
                        )
                      : ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) => TaskTile(
                            task: _tasks[index],
                            onToggle: () => _toggleTask(index),
                            onToggleImportant: () => _toggleImportant(index),
                            onDelete: () => _deleteTask(_tasks[index]),
                            onEdit: () => _editTask(index),
                            onConfirmDelete: _confirmDelete,
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
