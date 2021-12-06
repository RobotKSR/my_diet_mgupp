import 'package:flutter/material.dart';

Widget calculationCard(Context, Writing, Value, CardColor, WritingColor, Weight) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
    Container(
      width: MediaQuery.of(Context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: BoxDecoration(
          color: CardColor,
          /*border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),*/
          // Make rounded corners
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children:[
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Text(Writing,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: WritingColor,
                  fontFamily: 'Inter',
                ),
              )
            ),
            Text(Value,
              style: TextStyle(
                fontSize: 17,
                fontWeight: Weight,
                color: WritingColor,
                  fontFamily: 'Inter'
              ),
            ),
          ]
      )
  )
      ]
  );
}