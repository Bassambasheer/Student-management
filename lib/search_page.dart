import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddData.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:flutter_application_1/studentdetails.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      setState(() {});
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var data = studentList[index];
                      var encodedimg = data.img;
                      images = Base64Decoder().convert(encodedimg);
                      // print(data.name.contains('a'));
                      if (data.name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
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
                                            builder: (_) =>
                                                AddData(data: data)));
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
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (ctx, index) {
                      return Divider();
                    },
                    itemCount: studentList.length);
              },
            )),
          ],
        ),
      ),
    );
  }
}
