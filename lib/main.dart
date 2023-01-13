import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:my_todo/widgets/new_tasks.dart';

import '../widgets/tasks_list.dart';
import '../widgets/chart.dart';
import '../models/tasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Todo List",
      theme: ThemeData(
          primarySwatch: Colors.green,
          // ignore: deprecated_member_use
          accentColor: Colors.black,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late String titleValue;
  final titleController = TextEditingController();

  final labelController = TextEditingController();

  final List<Tasks> _userTasks = [
    Tasks(
        id: '1',
        title: 'Finishing My Project',
        lable: 'Task 1',
        date: DateTime.now()),
    Tasks(
        id: '2',
        title: 'Finishing the course',
        lable: 'Task 2',
        date: DateTime.now())
  ];

  List<Tasks> get _recentTasks {
    return _userTasks.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTasks(String tasksTitle, String tasksLabel) {
    final newTasks = Tasks(
        id: DateTime.now().toString(),
        title: tasksTitle,
        lable: tasksLabel,
        date: DateTime.now());
    setState(() {
      _userTasks.add(newTasks);
    });
  }

  void _startAddNewTask(BuildContext ctxt) {
    showModalBottomSheet(
        context: ctxt,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTasks(_addNewTasks),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        actions: <Widget>[
          IconButton(
              onPressed: () => _startAddNewTask(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Chart(_recentTasks), TasksList(_userTasks)]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() => _startAddNewTask(context)),
      ),
    );
  }
}
