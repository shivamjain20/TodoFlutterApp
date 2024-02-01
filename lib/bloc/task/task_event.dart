part of 'task_bloc.dart';

@immutable
abstract class TaskEvent{
  const TaskEvent();

  @override
  List <Object> get props => [];
}


class GetTasks extends TaskEvent{

}

/// Load the task

class LoadTask extends TaskEvent{
  final List<Task>tasks;

  const LoadTask({this.tasks = const<Task> []});

  @override
  List<Object> get props => [tasks];
}


/// Add the task
class AddTask extends TaskEvent{
  final Task task;

  const AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

/// Update the task
class UpdateTask extends TaskEvent{
  final Task task;

  const UpdateTask({required this.task});

  @override
  List<Object> get props => [task];
}

/// Delete the task
class DeleteTask extends TaskEvent{
  final Task task;

  const DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}


/// Search the task
class SearchBox extends TaskEvent{
  final String text;

  const SearchBox({required this.text});

  // @override
  // List<Object> get props => [task];
}

class CheckBox extends TaskEvent{
  final Task task;

  const CheckBox({required this.task});

  @override
  List<Object> get props => [task];
}

