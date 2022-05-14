import 'package:flutter/material.dart';

class acc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _acc();
}

class _acc extends State<acc> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: AssetImage('images/Frame 70.jpg'),
      ),
    );
  }
}
