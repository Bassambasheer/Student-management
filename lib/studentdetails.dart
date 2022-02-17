import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';

class StudentDetails extends StatefulWidget {
  StudentDetails({required this.data, Key? key}) : super(key: key);
  StudentModel data;
  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
     var encodedimg = widget.data.img ;
    final imag = Base64Decoder().convert(encodedimg);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
                width: 5,
              )),
              child: ListView(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      width: 100,
                      height: 100,
                      child: Image(image: MemoryImage(imag))),
                  SizedBox(height: 30),
                  Text(
                    " Name                 : ${widget.data.name.toUpperCase()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Text(
                    " Age                     : ${widget.data.age}",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Text(
                    " Class                  : ${widget.data.cls}",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Text(
                    " Admission No   : ${widget.data.admno}",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
