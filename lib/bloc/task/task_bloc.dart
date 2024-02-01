import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:todo/utils/database_helper.dart';
import '../../models/todo.dart';
import 'package:sqflite/sqflite.dart';

part 'task_event.dart';
part 'task_state.dart';


// List list = [1,2,3];
// Update(list)
// void Update(List list){
//   list.add(4)
// }
class TaskBloc extends Bloc<TaskEvent, TasksState> {

  List<Task> todoList = [];


  TaskBloc() : super(TasksLoaded()) {
    on<LoadTask>(_onLoadTask);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<SearchBox>(_onSearchbox);
    on<CheckBox>(_onCheckBox);
    on<GetTasks>(_onGetTasks);
  }

  Future<void> _onLoadTask(LoadTask event, Emitter<TasksState> emit) async {
    emit(TasksLoaded(tasks: todoList));
  }


  void _onGetTasks(GetTasks event, Emitter<TasksState>emit) async {
    emit(TasksLoaded(tasks: await DatabaseHelper().getAllTask()));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    // List<Task> demoTask = [...todoList];
    // demoTask.add(event.task);


    // todoList.add(event.task);
    // print('${todoList.length}');
    // todoList = demoTask;
    final databasehelper = DatabaseHelper();
    databasehelper.insert(event.task.toMap());
    emit(TasksLoaded(tasks: await DatabaseHelper().getAllTask()));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    // final state = this.state;
    // todoList.remove(event.task);
    // List<Task> tasks = todoList.where((task) {
    //   return task.id != event.task.id;
    // }).toList();
    // todoList = tasks;
    // todoList.removeWhere((item) => item.id==event.task.id);
    final databasehelper = DatabaseHelper();
    databasehelper.delete(event.task.id!);
    // emit(TasksLoaded(tasks: todoList));
    emit(TasksLoaded(tasks: await DatabaseHelper().getAllTask()));
  }


  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    // List <Task> tasks = (todoList.map((task) {
    //   return task.id == event.task.id ? event.task : task;
    // })).toList();
    // todoList = tasks;
    final databaseHelper = DatabaseHelper();
    databaseHelper.update(event.task.toMap());
    // emit(TasksLoaded(tasks: todoList));
    emit(TasksLoaded(tasks: await DatabaseHelper().getAllTask()));
  }

  void _onSearchbox(SearchBox event, Emitter<TasksState> emit) async {
    String texts = event.text.toString();
    List<Task>? searchlist = await DatabaseHelper().getAllTask();
    // final index = await searchlist.indexOf(text);
    if (texts.isEmpty) {
      // emit(TasksLoaded(tasks: todoList));
      emit(TasksLoaded(tasks: await DatabaseHelper().getAllTask()));
    }
    else {
           searchlist =  searchlist.where((item) =>
          item.todoText!.toLowerCase().contains(texts.toLowerCase())).toList();
      emit(TasksLoaded(tasks: await searchlist));
    }
  }

  void _onCheckBox(CheckBox event, Emitter<TasksState> emit) async{
    Task task = event.task;
    task.isDone = !task.isDone;
    emit(TasksLoaded(tasks: await DatabaseHelper().getAllTask()));
  }
}
