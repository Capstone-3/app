import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'myClosetApp/codyPage.dart';
import 'myClosetApp/weather.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '옷장 관리',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        color: Color.fromRGBO(239, 238, 245, 100),
        child: Center(
            child: ListView(
          children: <Card>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => weatherPage()));
                },
                child: Image(
                  image: AssetImage('images/dehumidifier.png'),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => codyPage()));
                },
                child: Image(
                  image: AssetImage('images/defuser.png'),
                ),
              ),
            ),
          ],
        )),
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
