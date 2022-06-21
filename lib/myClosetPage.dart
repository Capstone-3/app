import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'myClosetApp/defuser.dart';
import 'myClosetApp/dehumidifier.dart';

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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
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
            child: GridView.count(
          crossAxisCount: 2,
          children: <Card>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => dehumidifierPage()));
                },
                child: Image(
                  image: AssetImage('images/dehumidifier.png'),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => defuserPage()));
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
