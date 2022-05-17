import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class myClosetApp extends StatefulWidget {
  @override
  State<myClosetApp> createState() => _myClosetAppState();
}

class _myClosetAppState extends State<myClosetApp> {
  var _count = 1;
  var url = Uri.parse('http://192.168.200.139:5000/dehumi_post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 옷장'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  varCount();
                  _callAPI();
                },
                child: Text('ON')),
            ElevatedButton(
                onPressed: () {
                  varCount();
                  _callAPI2();
                },
                child: Text('OFF')),
            ElevatedButton(
                onPressed: () {
                  varCount();
                  _callAPI3();
                },
                child: Text('AUTO')),
          ],
        ),
      ),
    );
  }

  void _callAPI() async {
    await http.post(url, body: {'inst': 'ON', 'state': '$_count'});
  }

  void _callAPI2() async {
    await http.post(url, body: {'inst': 'OFF', 'state': '$_count'});
  }

  void _callAPI3() async {
    await http.post(url, body: {'inst': 'AUTO', 'state': '$_count'});
  }

  void varCount() {
    if (_count == 1) {
      _count = 2;
    } else {
      _count = 1;
    }
  }
}
