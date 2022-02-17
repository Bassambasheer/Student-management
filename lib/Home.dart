import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddData.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:flutter_application_1/search_page.dart';
import 'package:flutter_application_1/studentdetails.dart';

var images;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx2) => AddData()));
        },
        tooltip: 'Add New',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "STUDENT DETAILS",
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        actions: [ElevatedButton.icon(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SearchPage()));
          },
          icon: Icon(Icons.search),
          label: Text(''),
          ),
          ElevatedButton(
              onPressed: () {
                clear();
              },
              child: Text("clear")),
          
        ],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue[50],
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var data = studentList[index];
                var encodedimg = data.img;
                images = Base64Decoder().convert(encodedimg);
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => StudentDetails(data: data)));
                  },
                  title: Text(data.name.toUpperCase()),
                  leading: Image.memory(images),
                  trailing: Wrap(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddData(data: data)));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            if (data.id != null) {
                              deleteStudent(data.id!);
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return Divider();
              },
              itemCount: studentList.length);
        },
      )),
    );
  }
}
