import 'package:flutter/material.dart';

Widget activityCard(Context, Writing, ImagePath, CardColor, Argument) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
          primary: CardColor,
          onPrimary: Colors.grey.shade900,
          elevation: 5,
          textStyle: const TextStyle(
            fontSize: 20,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
          )
      ),
      onPressed: () {
        Navigator.pushNamed(Context, '/food_wishes', arguments: {'lifestyle': Argument});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Writing),
          Image(
            image: AssetImage(ImagePath),
            width: MediaQuery.of(Context).size.width * 0.25,
          ),
        ],
      )
      )
  );
}