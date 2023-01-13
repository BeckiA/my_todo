import 'package:flutter/foundation.dart';

class Tasks {
  final String id;
  final String title;
  final String lable;
  DateTime date;

  Tasks(
      {required this.id,
      required this.title,
      required this.lable,
      required this.date});
}
