import 'package:flutter/material.dart';

import '../../common/constants/app_styles.dart';
import '../../common/utils/extensions/double_extension.dart';
import '../../domain/entities/cloud_firestore/to_do.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final VoidCallback onDelete;
  final void Function(bool?)? onCheckboxed;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDelete,
    this.onCheckboxed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.docId!),
      background: Container(
        decoration: BoxDecoration(
          color: AppStyles.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            16.0.sizedBoxWidth,
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppStyles.fillGrey, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          todo.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                color: todo.isDone ? Colors.grey : Colors.black87,
              ),
        ),
        leading: Checkbox(
          value: todo.isDone,
          shape: const CircleBorder(),
          onChanged: onCheckboxed,
        ),
      ),
    );
  }
}
