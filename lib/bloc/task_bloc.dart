import 'package:bloc/bloc.dart';
import 'package:bloc_todo/database/database.dart';
import 'package:bloc_todo/model/todo.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Todo> todo = [];

  TaskBloc() : super(TaskInitial()) {
    on<TaskLoadFromDatabase>((event, emit) async {
      print('add event1');
      todo = await DatabaseHandler.instance.getDataBase();
      emit(TaskLoadSuccess(todo));
    });
    on<TaskAdd>((event, emit) async {
      await DatabaseHandler.instance
          .insertToDatabase(isDone: false, task: 'sdf', time: 'sdf');
      print('add event');
      todo = await DatabaseHandler.instance.getDataBase();
      emit(TaskLoadSuccess(todo));
      print('${todo}');
      print('printed from bloc');
    });
  }

  // @override
  // Stream<TaskState> mapEventToState(TaskEvent event) async* {
  //   DatabaseHandler.instance.createDatabase();
  //   if (event is TaskLoadFromDatabase) {
  //     todo = await DatabaseHandler.instance.getDataBase();
  //     yield TaskLoadSuccess(todo);
  //   } else if (event is TaskAdd) {
  //     todo = await DatabaseHandler.instance.getDataBase();
  //     yield TaskLoadSuccess(todo);
  //   } else if (event is TaskUpdate) {
  //     todo = await DatabaseHandler.instance.getDataBase();
  //     yield TaskLoadSuccess(todo);
  //   } else if (event is TaskDelete) {
  //     todo = await DatabaseHandler.instance.getDataBase();
  //     yield TaskLoadSuccess(todo);
  //   }
  // }
}
