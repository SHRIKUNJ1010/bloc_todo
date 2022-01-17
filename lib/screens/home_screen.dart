import 'package:bloc_todo/bloc/task_bloc.dart';
import 'package:bloc_todo/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var db1 = DatabaseHandler.instance;
  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: BlocBuilder<TaskBloc, TaskState>(
        bloc: TaskBloc(),
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 340,
                          color: Colors.blueAccent,
                          child: TextField(
                            controller: t1,
                            //onEditingComplete: () {},
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              //print('pressed');
                              context.read<TaskBloc>().add(TaskAdd(t1.text));
                              // BlocProvider.of<TaskBloc>(context)
                              //     .add(TaskAdd(t1.text));
                              //db.createDatabase();
                              // db1.insertToDatabase(
                              //     task: t1.text,
                              //     time: '${DateTime.now()}',
                              //     isDone: false);
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                  ),
                  state is TaskLoadSuccess
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.todos.length,
                          itemBuilder: (context, int i) {
                            return Container(
                              height: 100,
                              width: 300,
                              color: Colors.greenAccent,
                              child: Text('${state.todos[i].task}'),
                            );
                          },
                        )
                      : const SizedBox(
                          height: 10,
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
