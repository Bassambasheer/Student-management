import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final id = await studentDB.add(value);
  value.id = id;
  await studentDB.put(id, value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getAllStudents();
}

Future<void> editStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.put(value.id, value);
  getAllStudents();
}

clear() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.clear();
  getAllStudents();
}
