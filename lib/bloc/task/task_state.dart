part of 'task_bloc.dart';

@immutable
abstract class TasksState{
  const TasksState();

  // List<Object> get props => [];
}

class TasksLoading extends TasksState{}

class TasksLoaded extends TasksState{
  final List<Task> tasks;


  const TasksLoaded({this.tasks = const <Task>[]});

  // @override
  // List<Object> get props => [tasks];
}

class Taskserror extends TasksState{
  final String? message;
  const Taskserror(this.message);
}
