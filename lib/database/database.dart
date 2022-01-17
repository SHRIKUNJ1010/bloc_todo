import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bloc_todo/model/todo.dart';

class DatabaseHandler {
  static final DatabaseHandler instance = DatabaseHandler._init();
  DatabaseHandler._init() {
    createDatabase();
  }

  Database? db;

  void createDatabase() {
    if (db != null) {
      return;
    }
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db1, version) {
        db1
            .execute('''
            CREATE TABLE tasks(
              id INTEGER PRIMARY KEY,
              task TEXT,
              time TEXT,
              isDone TEXT
            )
          ''')
            .then((value) => print('Table Created'))
            .catchError((error) =>
                print('Error When Creating Table ${error.toString()}'));
      },
      onOpen: (db) {
        print('database opened');
      },
    ).then((value) {
      db = value;
    });
  }

  Future<List<Todo>> getDataBase() async {
    List<Todo> temp = [];
    await db!.transaction((txn) async {
      await txn.query('tasks').then((value) {
        //print('$value');
        value.forEach((element) {
          temp.add(Todo('${element['task']}', '${element['time']}',
              '${element['id']}', element['isDone'] == 1 ? true : false));
        });
      });
    });

    return temp;
  }

  insertToDatabase(
      {required String task,
      required String time,
      required bool isDone}) async {
    await db!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (task, time, isDone) VALUES ("$task","$time","${isDone ? 1 : 0}")')
          .then((value) {
        getDataBase();
        print('$value Inserted Successfully');
      }).catchError((error) {
        print('Error When inserting Table ${error.toString()}');
      });
    });
  }
}
