import 'package:flutter/material.dart';
import 'dart:developer';

class heightField extends StatefulWidget {
  const heightField({
    Key? key,
    this.active = false,
    required this.onChanged,
  }) : super(key: key);

  final bool active;
  final ValueChanged<int> onChanged;

  @override
  _heightFieldState createState() => _heightFieldState();
}

class _heightFieldState extends State<heightField> {
  int valueHolder = 170;

  void _onChanged(double newValue)  {
    setState(() {
      valueHolder = newValue.round();
    });
    widget.onChanged(valueHolder);
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
            Text('Рост', textAlign: TextAlign.center),
            Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Slider(
                    value: valueHolder.toDouble(),
                    min: 120,
                    max: 240,
                    divisions: 120,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    label: '${valueHolder.round()}',
                    onChanged:_onChanged,
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()}';
                    }
                )),
            Text('$valueHolder' + ' см',
              style: const TextStyle(
                fontSize: 17,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ))
          ],
        )
    );
  }
}