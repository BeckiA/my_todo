import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tasks.dart';
import '../widgets/Chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Tasks> recentTasks;

  Chart(this.recentTasks);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().add(
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
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'tasks': totalTasks
      };
    });
  }

  double get totalTasksAvailable {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + (item['tasks'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((info) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    info['day'] as String,
                    info['tasks'] as int,
                    totalTasksAvailable == 0
                        ? 0
                        : (info['tasks'] as int) / totalTasksAvailable),
              );
            }).toList()),
      ),
    );
  }
}
