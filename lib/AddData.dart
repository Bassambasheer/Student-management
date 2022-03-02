import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:flutter_application_1/widgets/constants.dart';
import 'package:flutter_application_1/Controller/controller.dart';
import 'package:flutter_application_1/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class AddData extends StatelessWidget {
   AddData({this.data, Key? key}) : super(key: key);
  final StudentModel? data;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  final _admnoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.put(Controller());
    if (data != null) {
      _nameController.text = data!.name;
      _ageController.text = data!.age;
      _classController.text = data!.cls;
      _admnoController.text = data!.admno;
      img = data!.img;
    }
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: black,
        title: const Text("Registration Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [
                GetBuilder<Controller>(
                  builder: (controller) {
                    return Container(
            height: 100,
            width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"))
          ),
            child: img.trim().isNotEmpty ? CircleAvatar(
              backgroundImage: MemoryImage(
                const Base64Decoder().convert(img)
              ),
            ): Container(),
          );
                  }
                ),
            IconButton(
                  onPressed: () async {
                    _controller.pickimage();
                  },
                  icon: const Icon(Icons.add_a_photo),
            ),
               ],
             ),
             space,
            AddDataField(controller: _nameController, text: "Full Name"),
            space,
            AddDataField(controller: _ageController, text: "Age"),
            space,
            AddDataField(controller: _classController, text: "Class"),
            space,
            AddDataField(
                controller: _admnoController, text: "Admission Number"),
            space,
            MaterialButton(
                textColor: Colors.white,
                color: Colors.black,
                onPressed: () {
                  if (data == null) {
                    onAdd();
                  } else {
                    onEdit();
                  }
                },
                child: const Text("Save")),
          ],
        ),
      ),
    );
  }

  Future<void> onAdd() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _class = _classController.text.trim();
    final _admno = _admnoController.text.trim();
    if (_name.isEmpty ||
        _age.isEmpty ||
        _class.isEmpty ||
        _admno.isEmpty ||
        img.isEmpty) {
      Get.snackbar("Error", "Try Adding every fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final _student = StudentModel(
        name: _name, age: _age, cls: _class, admno: _admno, img: img);
    addStudent(_student);
    Get.back();
  }

  Future<void> onEdit() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _class = _classController.text.trim();
    final _admno = _admnoController.text.trim();
    if (_name.isEmpty ||
        _age.isEmpty ||
        _class.isEmpty ||
        _admno.isEmpty ||
        img.isEmpty) {
      return;
    }
    final _student = StudentModel(
        id: data!.id,
        name: _name,
        age: _age,
        cls: _class,
        admno: _admno,
        img: img);
    editStudent(_student);
    Get.back();
  }
}
