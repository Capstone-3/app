import 'package:flutter/material.dart';

import 'myClosetApp/alarmTogglePage.dart';
import 'myClosetApp/itemsPage.dart';
import 'myClosetApp/statePage.dart';

class myClosetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 옷장'),
      ),
      body: Container(
        child: Center(
            child: ListView(
          children: <Card>[
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => statePage()));
                },
                child: Image(
                  image: AssetImage('images/State.jpg'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => itemsPage()));
                },
                child: Image(
                  image: AssetImage('images/Items.jpg'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => alarmTogglePage()));
                },
                child: Image(
                  image: AssetImage('images/AlarmToggle.jpg'),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
