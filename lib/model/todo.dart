import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String time;
  final bool isDone;

  @override
  List<Object> get props => [];

  Todo(this.task, this.time, this.id, this.isDone);
}
