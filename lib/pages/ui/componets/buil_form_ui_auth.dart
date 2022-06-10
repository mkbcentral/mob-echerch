import 'package:flutter/material.dart';

Widget builTextFormFieldAuth(
        {required String hintText,
        required Color bgColor,
        required TextInputType inputType,
        FormFieldValidator? validator,
        required BorderSide borderSide,
        required TextEditingController controler,
        bool isObscureText = false,
        obscureText,
        onTap}) =>
    TextFormField(
      controller: controler,
      keyboardType: inputType,
      validator: validator,
      obscureText: isObscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide,
          borderRadius: BorderRadius.circular(20.7),
        ),
      ),
    );

Widget builElevatedButton(
        {required String text,
        required Color bgColor,
        onPressed,
        required double raduiSize}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(raduiSize),
        ),
      ),
      child: Text(text),
    );

Widget buildLabelTextFormAuth(
        {required String text,
        required Color txtColor,
        required double textSize}) =>
    Text(
      text,
      style: TextStyle(color: txtColor, fontSize: textSize),
    );
Widget builTextButtonFormAuth(
        {required String text, required double textSize, onPressed}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: textSize),
        ));
