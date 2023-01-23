import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    // Tasks(
    //     id: '1',
    //     title: 'Finishing My Project',
    //     lable: 'Task 1',
    //     date: DateTime.now()),
    // Tasks(
    //     id: '2',
    //     title: 'Finishing the course',
    //     lable: 'Task 2',
    //     date: DateTime.now())
  ];
  bool _showChart = false;
  List<Tasks> get _recentTasks {
    return _userTasks.where((tx) {
      return tx.date.isBefore(DateTime.now().add(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTasks(String tasksTitle, String tasksLabel, DateTime inputDate) {
    final newTasks = Tasks(
        id: DateTime.now().toString(),
        title: tasksTitle,
        lable: tasksLabel,
        date: inputDate);
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

  void _deleteTasks(String id) {
    setState(() {
      _userTasks.removeWhere((taski) => taski.id == id);
    });
  }

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar = Platform.isIOS
        ? const CupertinoNavigationBar(
            middle: Text("Todo List"),
            trailing: null,
          )
        : AppBar(
            title: const Text("Todo List"),
            actions: <Widget>[
              IconButton(
                  onPressed: () => _startAddNewTask(context),
                  icon: const Icon(Icons.add))
            ],
          );

    final isLandscapeMode = mediaQuery.orientation == Orientation.landscape;
    final tasksList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TasksList(_userTasks, _deleteTasks));
    final pageBody = SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscapeMode)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Show chart"),
                Switch.adaptive(
                    // ignore: deprecated_member_use
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: ((val) {
                      setState(() {
                        _showChart = val;
                      });
                    }))
              ]),
            if (!isLandscapeMode)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(
                  _recentTasks,
                ),
              ),
            if (!isLandscapeMode) tasksList,
            if (isLandscapeMode)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(
                        _recentTasks,
                      ),
                    )
                  : tasksList,
          ]),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: (() => _startAddNewTask(context)),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
