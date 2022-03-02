import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

RxList<StudentModel> getController = <StudentModel>[].obs;
RxList<StudentModel> controllerSearch = <StudentModel>[].obs;

addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final id = await studentDB.add(value);
  value.id = id;
  await studentDB.put(id, value);
  getController.clear();
  getController.addAll(studentDB.values);
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  getController.clear();
  getController.addAll(studentDB.values);
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

