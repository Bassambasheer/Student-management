import 'package:flutter/material.dart';

class AddDataField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  AddDataField({
    Key? key,
    required this.controller,required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
          border: OutlineInputBorder(), hintText: text),
      textInputAction: TextInputAction.next,
    );
  }
}
