import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget littleRecipeInfo(title, description, mainColor) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    clipBehavior: Clip.antiAlias,
    elevation: 1.5,
    color: mainColor,
    child: Column(
      children: [
         //TODO: Make containers same width
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          child: Text(title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          child: Text(description,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
          ),
        ),
      ],
    ),
  );
}