import 'package:flutter/material.dart';

class Student with ChangeNotifier {
  String id;
  String? date;
  String? subject;
  String name;
  String rollNo;
  bool? isPresent;

  Student({
    required this.id,
    this.date,
    this.subject,
    required this.name,
    required this.rollNo,
    this.isPresent,
  });
  // void changeStatus() {
  //   isPresent = !isPresent;
  // }
}
