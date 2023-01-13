import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tasks.dart';

class Chart extends StatelessWidget {
  final List<Tasks> recentTasks;

  Chart(this.recentTasks);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      int totalTasks = 0;
      for (var i = 0; i < recentTasks.length; i++) {
        if (recentTasks[i].date.day == weekDay.day &&
            recentTasks[i].date.month == weekDay.month &&
            recentTasks[i].date.year == weekDay.year) {
          totalTasks += 1;
        }
      }
      return {'day': DateFormat.E().format(weekDay)., 'tasks': totalTasks};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Row(children: []),
    );
  }
}
