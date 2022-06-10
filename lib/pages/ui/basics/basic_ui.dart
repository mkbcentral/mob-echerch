import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(BuildContext context, String content) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));

Widget showGardientbg() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.black,
            Get.isDarkMode ? Colors.black38 : Colors.blue
          ]),
    ),
  );
}
