import 'dart:convert';

import 'package:attendance_uni_app/models/http_exception.dart';
import 'package:attendance_uni_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Students with ChangeNotifier {
  List<Student> _studentsNew = [];

  List<Student> get studentsNew {
    return [..._studentsNew];
  }

  Future addNewStudent(Student newStudent) async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/RegularStudent.json'); // collection name
    try {
      final value = await http.post(url,
          body: json.encode({
            'name': newStudent.name,
            'roll No': newStudent.rollNo,
            'isPresent': newStudent.isPresent,
            // 'isFavorite': product.isFavorite
          }));

      // print(json.decode(value.body));
      final newProduct = Student(
        id: json.decode(value.body)['name'],
        name: newStudent.name,
        rollNo: newStudent.rollNo,
        isPresent: newStudent.isPresent,
      );
      // description: product.description,
      // price: product.price,
      // imageUrl: product.imageUrl);
      _studentsNew.add(newProduct);
      notifyListeners();

      // .catchError((error) {
      //   print(error);
      //   throw error;
      // });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetStudent() async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/RegularStudent.json'); // collection name
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
        _studentsNew = loadedStudents;
      });
    } catch (error) {
      rethrow;
    }
  }

  // void onpressNull(String id) async {
  //   final index = _studentsNew.indexWhere((repStud) => repStud.id == id);
  //   studentsNew.removeAt(index);
  //   notifyListeners();
  // }

  Future<void> deleteNewStud(String id) async {
    final newId = _studentsNew.indexWhere((stud) => stud.id == id);
    Student? newStudent = _studentsNew[newId];
    _studentsNew.removeAt(newId);
    notifyListeners();
    notifyListeners();
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/RegularStudent/$id.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _studentsNew.insert(newId, newStudent);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    newStudent = null;
  }
}
