import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTasks extends StatefulWidget {
  late Function addTasks;
  NewTasks(this.addTasks);

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  final titleController = TextEditingController();

  final labelController = TextEditingController();
  DateTime? _selectedDate;
  void submitData() {
    if (labelController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredLable = labelController.text;

    if (enteredTitle.isEmpty || enteredLable.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTasks(enteredTitle, enteredLable, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                // onChanged: (value) {
                //   titleValue = value;
                // },
                controller: titleController,
                onSubmitted: ((_) => submitData()),
              ),
              TextField(
                  decoration: const InputDecoration(
                    labelText: "Label",
                  ),
                  controller: labelController,
                  onSubmitted: ((_) => submitData()
                      // onChanged: (value) => labelValue = value,
                      )),
              Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? "No date chosen"
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}')),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text(
                        'Choose a date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              ElevatedButton(
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  submitData();
                },
              ),
            ],
          )),
    );
  }
}
