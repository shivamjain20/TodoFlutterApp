import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/todo.dart';
import '../bloc/task/task_bloc.dart';

class ListTileItem extends StatefulWidget {
  final Task todoItem;
  final List<Task> TODOLIST;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ListTileItem({
    super.key,
    required this.todoItem,
    required this.TODOLIST,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<ListTileItem> createState() => _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          // BlocProvider.of<TaskBloc>(context).add(CheckBox(task: widget.todoItem));
          Task task = widget.todoItem;
          task.isDone = !task.isDone;
          BlocProvider.of<TaskBloc>(context).add(UpdateTask(task: task));
          // setState(() {
          //   widget.todoItem.isDone = !widget.todoItem.isDone;
          // });
        },
        leading: Icon(
          widget.todoItem.isDone
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: Colors.black,
          size: 30,
        ),
        title: Text(
          '${widget.todoItem.todoText}',
          style: TextStyle(
              decoration:
              widget.todoItem.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Container(
                color: Colors.green,
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  color: Colors.white,
                  icon: const Icon(Icons.edit),
                  onPressed: widget.onEdit,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                color: Colors.red,
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  color: Colors.white,
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onDelete,
                  // onPressed: (){
                  //   context.read<TaskBloc>().add(UpdateTask(
                  //       task: task.copywith(isDone: !task.isDone)));
                  // },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
