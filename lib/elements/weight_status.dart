import 'package:flutter/material.dart';

Widget weightStatusCard(Context, Writing, Value, CardColor, WritingColor) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: MediaQuery.of(Context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
                color: CardColor,
                /*border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),*/
                // Make rounded corners
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(Writing,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'OpenSans'
                    ),
                  ),
                  Text(Value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                        fontFamily: 'OpenSans'
                    ),
                  ),
                ]
            )
        )
      ]
  );
}