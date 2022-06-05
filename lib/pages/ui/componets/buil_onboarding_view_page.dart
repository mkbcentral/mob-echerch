import 'package:flutter/material.dart';

Widget buildOnboardingViewPage(
        {required Color color,
        required String urlImage,
        required String title,
        required String subTilte}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              subTilte,
              style: const TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
