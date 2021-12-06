import 'package:flutter/material.dart';
import 'dart:developer';

class ageField extends StatefulWidget {
  const ageField({
    Key? key,
    this.active = false,
    required this.onChanged,
  }) : super(key: key);

  final bool active;
  final ValueChanged<String> onChanged;

  @override
  _ageFieldState createState() => _ageFieldState();
}

class _ageFieldState extends State<ageField> {
  List<String> groups = ['18-25', '26-35', '36-55', '56-65', '65+'];
  int currentGroup = 0;

  void _handlePress() {
    setState(() {
      if(currentGroup < groups.length -1) {
        currentGroup += 1;
      }else{
        currentGroup = 0;
      }
    });
    widget.onChanged(groups[currentGroup]);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
        onPressed: _handlePress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage('assets/graphics/age_group.png') ,
              width: MediaQuery.of(context).size.width * 0.17,
            ),
            SizedBox(height: 7),
            Text(groups[currentGroup] + ' лет', textAlign: TextAlign.center),
          ],
        )
    );
  }
}