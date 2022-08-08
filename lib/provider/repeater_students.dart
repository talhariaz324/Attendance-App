import 'dart:convert';

import 'package:attendance_uni_app/models/http_exception.dart';
import 'package:attendance_uni_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepStudents with ChangeNotifier {
  List<Student> _repeaterStu = [
    // Student(
    //     id: const Uuid().v1(),
    //     name: 'Moeez Ahamd',
    //     rollNo: 'bsf2000799',
    //     isPresent: true),
    // Student(
    //     id: const Uuid().v1(),
    //     name: 'Anas Afzal',
    //     rollNo: 'bsf2000495',
    //     isPresent: false),
    // Student(
    //     id: const Uuid().v1(),
    //     name: 'Bilal Khalid',
    //     rollNo: 'bsf2000681',
    //     isPresent: true),
    // Student(
    //     id: const Uuid().v1(),
    //     name: 'Talha Riaz',
    //     rollNo: 'bsf2000500',
    //     isPresent: false),
  ];
  List<Student> get repeaterStu {
    return [..._repeaterStu];
  }

  Future addRepeaterStudent(Student repStudent) async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/RepeaterStudent.json'); // collection name
    try {
      final value = await http.post(url,
          body: json.encode({
            'name': repStudent.name,
            'roll No': repStudent.rollNo,
            'isPresent': repStudent.isPresent,
            // 'isFavorite': product.isFavorite
          }));

      // print(json.decode(value.body));
      final newProduct = Student(
        id: json.decode(value.body)['name'],
        name: repStudent.name,
        rollNo: repStudent.rollNo,
        isPresent: repStudent.isPresent,
      );
      // description: product.description,
      // price: product.price,
      // imageUrl: product.imageUrl);
      _repeaterStu.add(newProduct);
      notifyListeners();

      // .catchError((error) {
      //   print(error);
      //   throw error;
      // });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetRepStudent() async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/RepeaterStudent.json'); // collection name
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<Student> loadedStudents = [];
      extractedData.forEach((studentId, studentData) {
        loadedStudents.add(Student(
          id: studentId,
          name: studentData['name'],
          rollNo: studentData['roll No'],
          isPresent: studentData['isPresent'],
        ));
        _repeaterStu = loadedStudents;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteRepStud(String id) async {
    final newId = _repeaterStu.indexWhere((stud) => stud.id == id);
    Student? newStudent = _repeaterStu[newId];
    _repeaterStu.removeAt(newId);
    notifyListeners();
    notifyListeners();
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/RepeaterStudent/$id.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _repeaterStu.insert(newId, newStudent);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    newStudent = null;
  }
}
