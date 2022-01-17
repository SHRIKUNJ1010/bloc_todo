part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskLoadFromDatabase extends TaskEvent {}

class TaskAdd extends TaskEvent {
  final String text;

  const TaskAdd(this.text);

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TodoAdded { todo: $text }';
}

class TaskUpdate extends TaskEvent {
  final Todo todo;

  const TaskUpdate(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoUpdated { todo: $todo }';
}

class TaskDelete extends TaskEvent {
  final Todo todo;

  const TaskDelete(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoDeleted { todo: $todo }';
}
