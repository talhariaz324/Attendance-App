import 'dart:convert';

import 'package:attendance_uni_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Subject<String> with ChangeNotifier {
  final String id;
  final String subName;
  Subject({
    required this.subName,
    required this.id,
  });
}

class Subjects with ChangeNotifier {
  List<Subject> _subjects = [
    // Subject(subName: 'English', id: const Uuid().v1()),
    // Subject(subName: 'Maths', id: const Uuid().v1()),
    // Subject(subName: 'Physics', id: const Uuid().v1()),
    // Subject(subName: 'Chemsitry', id: const Uuid().v1()),
    // Subject(subName: 'Urdu', id: const Uuid().v1()),
    // Subject(subName: 'Islamiyat', id: const Uuid().v1()),
  ];

  List<Subject> get subjects {
    return [..._subjects];
  }

  // void addSubject(String subject) {
  //   _subjects.add(Subject(subName: subject, id: const Uuid().v1()));
  //   print(subject);
  //   notifyListeners();
  // }
  Future addSubject(Subject subject) async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/SUBJECTS.json'); // collection name
    try {
      final value = await http.post(url,
          body: json.encode({
            'subName': subject.subName,
            // 'price': product.price,
            // 'imageUrl': product.imageUrl,
            // 'isFavorite': product.isFavorite
          }));

      // print(json.decode(value.body));
      final newProduct = Subject(
        id: json.decode(value.body)['name'],
        subName: subject.subName,
      );
      // description: product.description,
      // price: product.price,
      // imageUrl: product.imageUrl);
      _subjects.add(newProduct);
      notifyListeners();

      // .catchError((error) {
      //   print(error);
      //   throw error;
      // });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSet() async {
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/SUBJECTS.json');
    try {
      final response = await http.get(url);
      final List<Subject> gettedSubj = [];

      final getData = json.decode(response.body) as Map<String, dynamic>?;
      if (getData == null) {
        return;
      }
      getData.forEach((prodId, prodData) {
        gettedSubj.insert(
          0,
          Subject(
            id: prodId,
            subName: prodData['subName'],
          ),
        );
      });
      _subjects = gettedSubj;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSubj(String id) async {
    final subjId = _subjects.indexWhere((subj) => subj.id == id);
    Subject? subject = _subjects[subjId];
    _subjects.removeAt(subjId);
    notifyListeners();
    notifyListeners();
    final url = Uri.parse(
        'https://education-attendance-a39b8-default-rtdb.firebaseio.com/SUBJECTS/$id.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _subjects.insert(subjId, subject);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    subject = null;
  }
}
