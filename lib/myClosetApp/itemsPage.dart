import 'package:flutter/material.dart';

class itemsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _itemsPage();
}

class _itemsPage extends State<itemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('itemsPage'),
      ),
    );
  }
}
