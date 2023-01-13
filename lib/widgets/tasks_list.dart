import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tasks.dart';

class TasksList extends StatelessWidget {
  final List<Tasks> tasks;

  TasksList(this.tasks);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: tasks.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'You have no tasks in your todo yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Theme.of(context).primaryColor),
                          // borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          tasks[index].lable,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tasks[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat.yMMMd().format(tasks[index].date),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ));
                },
                itemCount: tasks.length));
  }
}
