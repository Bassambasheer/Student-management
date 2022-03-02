import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/constants.dart';

class textWidget extends StatelessWidget {
 final  String title;

  const textWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Text(
     title,
      style: const TextStyle(
        color: black,
        fontSize: 22,
      ),
    );
  }
}