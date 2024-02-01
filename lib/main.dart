import 'package:flutter/material.dart';
import 'package:todo/search/bottom.dart';
import 'package:todo/search/edit.dart';
import 'package:todo/search/searchbox.dart';
import 'package:todo/utils/database_helper.dart';
import '../models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import '../bloc/task/task_bloc.dart';
import '../listtile/list_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  late DatabaseHelper dbHelper;
  var titleController = TextEditingController();

  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    this.dbHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: const MaterialApp(
        title: 'Todo App',
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  // @override
  // void initState(){
  //   super.initState();
  //   _scrollController = ScrollController(initialScrollOffset: 0);
  // }

  Widget build(BuildContext context) {
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 3), () {
        BlocProvider.of<TaskBloc>(context).add(GetTasks());
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          )
        ],
      ),
      body: BlocConsumer<TaskBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksLoaded) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          }
        },
        builder: (context, state) {
          print('state: ${state.toString()}');
          if (state is TasksLoading) {
            return const CircularProgressIndicator();
          } else if (state is TasksLoaded) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Searchbox(),
                    Expanded(
                        child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SafeArea(
                          child: ListTileItem(
                            todoItem: state.tasks[index],
                            TODOLIST: state.tasks,
                            onDelete: () {
                              Task task = state.tasks[index];
                              taskBloc.add(DeleteTask(task: task));
                              print('DELETE PRESSED');
                            },
                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return edit_dialog(
                                      id: state.tasks[index].id!,
                                      todoText: state.tasks[index].todoText!);
                                },
                              );
                            },
                          ),
                        );
                      },
                      itemCount: state.tasks.length,
                    )),
                    Bottom(),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
