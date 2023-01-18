import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String label;
  late final int numberOfTasks;
  late final double numberOfTasksPct;

  ChartBar(this.label, this.numberOfTasks, this.numberOfTasksPct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20, child: FittedBox(child: Text('${numberOfTasks}'))),
        const SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
              heightFactor: numberOfTasksPct,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ]),
        ),
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
