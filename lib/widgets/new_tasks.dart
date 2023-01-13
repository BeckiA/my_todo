import 'package:flutter/material.dart';

class NewTasks extends StatefulWidget {
  late Function addTasks;
  NewTasks(this.addTasks);

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  final titleController = TextEditingController();

  final labelController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredLable = labelController.text;

    if (enteredTitle.isEmpty || enteredLable.isEmpty) {
      return;
    }
    widget.addTasks(enteredTitle, enteredLable);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                // onChanged: (value) {
                //   titleValue = value;
                // },
                controller: titleController,
                onSubmitted: ((_) => submitData()),
              ),
              TextField(
                  decoration: InputDecoration(
                    labelText: "Label",
                  ),
                  controller: labelController,
                  onSubmitted: ((_) => submitData()
                      // onChanged: (value) => labelValue = value,
                      )),
              TextButton(
                child: Text('Add Transaction'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  widget.addTasks(titleController.text, labelController.text);
                },
              ),
            ],
          )),
    );
  }
}
