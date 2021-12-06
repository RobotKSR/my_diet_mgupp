import 'package:flutter/material.dart';
import 'dart:developer';

class foodtypeField extends StatefulWidget {
  const foodtypeField({
    Key? key,
    this.active = false,
    required this.onChanged,
  }) : super(key: key);

  final bool active;
  final ValueChanged<String> onChanged;

  @override
  _foodtypeFieldState createState() => _foodtypeFieldState();
}

class _foodtypeFieldState extends State<foodtypeField> {
  String foodtype = 'normal';
  String foodtypeRus = 'Мясоед';

  void _handlePress() {
    setState(() {
      if(foodtype == 'normal'){
        foodtype = 'vegeterian';
        foodtypeRus = "Вегетерианец";
      }else{
        foodtype = 'normal';
        foodtypeRus = "Мясоед";
      }
    });
    widget.onChanged(foodtype);
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
              image: (foodtype == "normal") ? AssetImage('assets/graphics/meat.png') : AssetImage('assets/graphics/salad.png'),
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            Text(foodtypeRus, textAlign: TextAlign.center)
          ],
        )
    );
  }
}