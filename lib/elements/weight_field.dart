import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/services.dart';

class weightField extends StatefulWidget {
  const weightField({
    Key? key,
    required this.title,
    required this.writing,
    this.active = false,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String writing;
  final bool active;
  final ValueChanged<double> onChanged;

  @override
  _weightFieldState createState() => _weightFieldState();
}

class _weightFieldState extends State<weightField> {

  void _setLatestValue(text) {
    try {
      widget.onChanged(double.parse(text));
    }catch(ex){
      widget.onChanged(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
            primary: Colors.white,
            onPrimary: Colors.black,
            elevation: 5,
            textStyle: const TextStyle(
              fontSize: 17,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            )
        ),
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.title, textAlign: TextAlign.center),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                textAlign: TextAlign.center,
                onChanged: _setLatestValue,
                autocorrect: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d*\.?\d*'))
                ],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'XX.X',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Text(widget.writing, textAlign: TextAlign.center),
          ],
        )
    );
  }
}