import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:flutter_application_1/studentdetails.dart';
import 'package:flutter_application_1/Controller/controller.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget{
   SearchPage({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoSearchTextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchList(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = controllerSearch[index];
                        var encodedimg = data.img;
                        images = const Base64Decoder().convert(encodedimg);
                        if (data.name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                               color: Colors.grey[400],
                              child: ListTile(
                                onTap: () {
                                  Get.to(StudentDetails(data: data));
                                },
                                title: Text(data.name.toUpperCase()),
                                leading: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.memory(images),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(height: 4);
                      },
                      itemCount: controllerSearch.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
