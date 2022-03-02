import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/widgets/constants.dart';
import 'package:flutter_application_1/widgets/text_widget.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails({required this.data, Key? key}) : super(key: key);
  StudentModel data;
 
  @override
  Widget build(BuildContext context) {
     var encodedimg = data.img ;
    final imag = const Base64Decoder().convert(encodedimg);
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: black,
        ),
        body: Center(
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                       color: black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
                    ),
                    width: double.infinity,
                    height: 200,
                  ),
                  Center(
                    child: CircleAvatar(
                        backgroundImage: MemoryImage(imag),radius: 60,),
                  ),
                ],
              ),
             space,
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const textWidget(title: "FULL NAME :",),
                  height10,
                  textWidget(title: data.name),
                ],
              ),
             space,
             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 textWidget(title: "AGE :",),
                  height10,
                  textWidget(title: data.age),
               ],
             ),
             space,
             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 textWidget(title: "CLASS :",),
                  height10,
                  textWidget(title: data.cls),
               ],
             ),
             space,
             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 textWidget(title: "REG NO :",),
                  height10,
                  textWidget(title: data.admno),
               ],
             ),
             
            ],
          ),
        ),
      ),
    );
  }
}


