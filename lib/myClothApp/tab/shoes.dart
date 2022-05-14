import 'package:flutter/material.dart';

class shoes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _shoes();
}

class _shoes extends State<shoes> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: AssetImage('images/Frame 70.jpg'),
      ),
    );
  }
}
