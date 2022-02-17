import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:image_picker/image_picker.dart';

class AddData extends StatefulWidget {
  AddData({this.data, Key? key}) : super(key: key);
  StudentModel? data;

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  File? image;

  String img = '';

  TextEditingController _nameController = TextEditingController();

  TextEditingController _ageController = TextEditingController();

  TextEditingController _classController = TextEditingController();

  TextEditingController _admnoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      _nameController.text = widget.data!.name;
      _ageController.text = widget.data!.age;
      _classController.text = widget.data!.cls;
      _admnoController.text = widget.data!.admno;
      img = widget.data!.img;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Full Name"),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              width: double.infinity,
              height: 25,
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Age"),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              width: double.infinity,
              height: 25,
            ),
            TextField(
              controller: _classController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Class"),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              width: double.infinity,
              height: 25,
            ),
            TextField(
              controller: _admnoController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Admission Number"),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              width: double.infinity,
              height: 25,
            ),
            image != null ? Image.file(image!) : Container(),
            IconButton(
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage == null) {
                  return;
                } else {
                  image = File(pickedImage.path);
                  setState(() {});
                  final bytes = File(pickedImage.path).readAsBytesSync();
                  img = base64Encode(bytes);
                }
              },
              icon: Icon(Icons.add_a_photo),
            ),
            ElevatedButton(
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (widget.data == null) {
                    onAdd();
                    print(img.length);
                  } else {
                    onEdit();
                  }
                  // Navigator.of(context)
                  //     .pop(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                },
                child: Text("Save")),
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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Details Missing , Try adding Every Fields")));
      return;
    }
    final _student = StudentModel(
        name: _name, age: _age, cls: _class, admno: _admno, img: img);
    addStudent(_student);
    Navigator.of(context)
        .pop(MaterialPageRoute(builder: (ctx) => HomeScreen()));
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
        id: widget.data!.id,
        name: _name,
        age: _age,
        cls: _class,
        admno: _admno,
        img: img);
    editStudent(_student);
   Navigator.of(context)
        .pop(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
}
