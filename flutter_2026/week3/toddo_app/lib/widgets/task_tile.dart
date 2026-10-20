import 'package:flutter/material.dart';
import 'package:todo_app/models/tasks.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onToggleImportant;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Future<bool> Function() onConfirmDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onToggleImportant,
    required this.onDelete,
    required this.onEdit,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(task),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => onConfirmDelete(),
      onDismissed: (_) => onDelete(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        onTap: onEdit,
        // Long-press toggles whether this task is marked as important.
        onLongPress: onToggleImportant,
        leading: Checkbox(value: task.isDone, onChanged: (_) => onToggle()),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? Colors.grey : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (task.isImportant)
              const Icon(Icons.star, color: Colors.amber),
            IconButton(
              tooltip: 'Delete task',
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                if (await onConfirmDelete()) onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
