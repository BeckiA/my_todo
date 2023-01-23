import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String label;
  late final int numberOfTasks;
  late final double numberOfTasksPct;

  ChartBar(this.label, this.numberOfTasks, this.numberOfTasksPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text('${numberOfTasks}'))),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
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
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(height: constraints.maxHeight * 0.15, child: Text(label))
          ],
        );
      },
    );
  }
}
