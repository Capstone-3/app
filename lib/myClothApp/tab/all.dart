import 'package:flutter/material.dart';

class all extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _all();
}

class _all extends State<all> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: AssetImage('images/Frame 70.jpg'),
      ),
    );
  }
}
