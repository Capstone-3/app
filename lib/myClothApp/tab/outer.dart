import 'package:flutter/material.dart';

class outer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _outer();
}

class _outer extends State<outer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: AssetImage('images/Frame 70.jpg'),
      ),
    );
  }
}
