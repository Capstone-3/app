import 'package:flutter/material.dart';

class pants extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _pants();
}

class _pants extends State<pants> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: AssetImage('images/Frame 70.jpg'),
      ),
    );
  }
}
