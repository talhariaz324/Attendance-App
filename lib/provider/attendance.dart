import 'dart:convert';
import 'package:attendance_uni_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Attendance with ChangeNotifier {
  List<Student> _attendance = [];

  List<Student> get attendance {
    return [..._attendance];
  }

  Future addAttendance(Student attendance) async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/Attendance.json'); // collection name
    try {
      final value = await http.post(url,
          body: json.encode({
            'date': attendance.date,
            'name': attendance.name,
            'roll No': attendance.rollNo,
            'isPresent': attendance.isPresent,
            'subject': attendance.subject
            // 'isFavorite': product.isFavorite
          }));

      // print(json.decode(value.body));
      final newProduct = Student(
        id: json.decode(value.body)['name'],
        date: attendance.date,
        subject: attendance.subject,
        name: attendance.name,
        rollNo: attendance.rollNo,
        isPresent: attendance.isPresent,
      );
      // description: product.description,
      // price: product.price,
      // imageUrl: product.imageUrl);
      _attendance.add(newProduct);
      notifyListeners();

      // .catchError((error) {
      //   print(error);
      //   throw error;
      // });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetData(
      {required String date, required String subject}) async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/Attendance.json'); // collection name
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<Student> loadedData = [];
      extractedData.forEach((studentId, studentData) {
        loadedData.add(Student(
          id: studentId,
          date: studentData['date'],
          subject: studentData['subject'],
          name: studentData['name'],
          rollNo: studentData['roll No'],
          isPresent: studentData['isPresent'],
        ));

        _attendance = loadedData
            .where((data) => data.date == date && data.subject == subject)
            .toList();
      });
    } catch (error) {
      rethrow;
    }
  }
}
