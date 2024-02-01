import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/task_bloc.dart';
import '../models/todo.dart';

class edit_dialog extends StatefulWidget {
  final String id;
  final String todoText;

  const edit_dialog({super.key, required this.id, required this.todoText});

  @override
  State<edit_dialog> createState() => _edit_dialogState();
}

class _edit_dialogState extends State<edit_dialog> {
  late TextEditingController titleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.todoText);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          TextFormField(
        controller: titleController,

        // titleController.text: todoList[index]!.todoText!,
        decoration: InputDecoration(
          labelText: 'Todo Text',
          // hintText: '${widget.todoText}',
        ),
        ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('UPDATE'),
          onPressed: () {
            Task task = Task(id: widget.id, todoText: titleController.text);
            BlocProvider.of<TaskBloc>(context).add(UpdateTask(task: task));
            titleController.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
