import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tasks.dart';

class TasksList extends StatelessWidget {
  final List<Tasks> tasks;
  final Function deleteTasks;

  TasksList(this.tasks, this.deleteTasks);
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
                  const SizedBox(
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
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(child: Text(tasks[index].lable)),
                          ),
                        ),
                        title: Text(
                          tasks[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle:
                            Text(DateFormat.yMMMd().format(tasks[index].date)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: (() {
                            deleteTasks(tasks[index].id);
                          }),
                        ),
                      ));
                },
                itemCount: tasks.length));
  }
}
