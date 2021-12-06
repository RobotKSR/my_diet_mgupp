import 'package:flutter/material.dart';

void showToast(String toastText, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
     SnackBar(
      content: Text(toastText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    ),
  );
}