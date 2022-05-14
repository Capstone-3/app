import 'package:flutter/material.dart';

class weatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _weatherPage();
}

class _weatherPage extends State<weatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weatherPage'),
      ),
    );
  }
}
