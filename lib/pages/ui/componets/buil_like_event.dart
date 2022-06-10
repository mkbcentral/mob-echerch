import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget builLikeEventCustom(int value, IconData icon, Color color, onPressed) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 18,
              color: color,
            )),
        const SizedBox(
          width: 4,
        ),
        Text("$value"),
      ],
    ),
  ));
}
