import 'package:flutter/material.dart';

Widget topBar() {
  return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Моя Диета', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'OpenSans')),
            Image(
              image: AssetImage('assets/graphics/mgupp_logo.png'),
              height: 50,
            ),
          ]
  );
}