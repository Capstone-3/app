import 'package:flutter/material.dart';

class statePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _statePage();
}

class _statePage extends State<statePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('statePage'),
      ),
    );
  }
}
