import 'package:flutter/material.dart';
import 'dart:developer';

class wantCard extends StatefulWidget {
  const wantCard({
    Key? key,
    required this.writing,
    required this.imagePath,
    required this.type,
    this.active = false,
    required this.onChanged,
  }) : super(key: key);

  final String writing;
  final String imagePath;
  final String type;
  final bool active;
  final ValueChanged<Map> onChanged;

  @override
  _wantCardState createState() => _wantCardState();
}

class _wantCardState extends State<wantCard> {
  bool _highlight = false;

  void _handlePress() {
    widget.onChanged({ 'active': !_highlight, 'type': widget.type });
    setState(() {
      _highlight = !_highlight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
            primary: _highlight ? Colors.greenAccent : Colors.white,
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
              image: AssetImage(widget.imagePath),
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            Text(widget.writing, textAlign: TextAlign.center)
          ],
        )
    );
  }
}