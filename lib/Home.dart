import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddData.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:flutter_application_1/search_page.dart';
import 'package:flutter_application_1/studentdetails.dart';
import 'package:flutter_application_1/widgets/constants.dart';
import 'package:flutter_application_1/Controller/controller.dart';
import 'package:get/get.dart';

var images;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        onPressed: () {
          img = '';
          Get.to(AddData());
        },
        tooltip: 'Add New',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: black,
        centerTitle: true,
        title: const Text(
          "STUDENT DETAILS",
        ),
        actions: [
          IconButton(
              onPressed: () {
                searchList("");
                Get.to(SearchPage());
              },
              icon: Icon(Icons.search))
        ],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: white,
      body: SafeArea(child: Obx(
        () {
          return ListView.separated(
              itemBuilder: (context, index) {
                var data = getController[index];
                var encodedimg = data.img;
                images = Base64Decoder().convert(encodedimg);
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                    color: Colors.grey[200],
                    child: ListTile(
                      onTap: () {
                        Get.to(StudentDetails(data: data));
                      },
                      title: Text(data.name.toUpperCase()),
                      leading: Container(
                        width: 50,height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: DecorationImage(image: MemoryImage(images))
                        )
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.to(AddData(
                                  data: data,
                                ));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                if (data.id != null) {
                                  deleteStudent(data.id!);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 0);
              },
              itemCount: getController.length);
        },
      )),
    );
  }
}
