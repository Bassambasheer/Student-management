import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/db/model/data_model.dart';
import 'package:flutter_application_1/db/model/functions/db_functions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


searchList(String value) {
  controllerSearch.clear();
  for (var item in getController) {
    if (item.name.toString().toLowerCase().contains(value.toLowerCase())) {
      StudentModel data = StudentModel(
          name: item.name,
          age: item.age,
          cls: item.cls,
          admno: item.admno,
          img: item.img);
          
      controllerSearch.add(data);
    }
  }
}

File? image;
String img = '';

class Controller extends GetxController {
  pickimage() async {

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      image = File(pickedImage.path);
      update();
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
  }
}

