import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String cls;
  @HiveField(4)
  final String admno;
  @HiveField(5)
   String img;

  StudentModel(
      {required this.name,
      required this.age,
      required this.cls,
      required this.admno,
      required this.img,
      this.id});
}
