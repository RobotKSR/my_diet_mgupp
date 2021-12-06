import 'package:flutter/material.dart';
import 'dart:developer';

class genderField extends StatefulWidget {
  const genderField({
    Key? key,
    this.active = false,
    required this.onChanged,
  }) : super(key: key);

  final bool active;
  final ValueChanged<String> onChanged;

  @override
  _genderFieldState createState() => _genderFieldState();
}

class _genderFieldState extends State<genderField> {
  String gender = 'female';
  String genderRus = 'Женщина';

  void _handlePress() {
    setState(() {
      if(gender == 'male'){
        gender = 'female';
        genderRus = "Женщина";
      }else{
        gender = 'male';
        genderRus = "Мужчина";
      }
    });
    widget.onChanged(gender);
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
              image: (gender == "male") ? AssetImage('assets/graphics/male.png') : AssetImage('assets/graphics/female.png'),
              width: MediaQuery.of(context).size.width * 0.17,
            ),
            SizedBox(height: 7),
            Text(genderRus, textAlign: TextAlign.center)
          ],
        )
    );
  }
}