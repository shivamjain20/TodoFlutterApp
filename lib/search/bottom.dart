import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/task/task_bloc.dart';

import '../models/todo.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  final _todoController = TextEditingController();
  // ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      children: [
        Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                    hintText: 'Add new item',
                    border: InputBorder.none),
              ),
            )),
        Container(
          margin: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              Task task = Task(
                  id: DateTime.now()
                      .microsecondsSinceEpoch
                      .toString(),
                  todoText: _todoController.text);
              // widget.callback();
              BlocProvider.of<TaskBloc>(context).add(AddTask(task: task));
              _todoController.clear();
              FocusScope.of(context).unfocus();
              // setState(() {

              // });

              // _scrollController.
            },
            style: ElevatedButton.styleFrom(
                elevation: 10, minimumSize: const Size(50, 50)),
            child: const Text(
              '+',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        )
      ],
    ),
    );
  }
}
