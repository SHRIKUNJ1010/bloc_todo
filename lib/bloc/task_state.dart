part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Todo> todos;

  const TaskLoadSuccess(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'Task Loaded Success {task: $todos}';
}
