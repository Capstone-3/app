import 'package:flutter/material.dart';

class top extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _top();
}

class _top extends State<top> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: AssetImage('images/Frame 70.jpg'),
      ),
    );
  }
}
