import 'package:flutter/material.dart';

import 'home/codyPage.dart';
import 'home/framePage.dart';
import 'home/weather.dart';

class homeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hicloset'),
      ),
      body: Container(
        child: Center(
            child: ListView(
          children: <Card>[
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => weatherPage()));
                },
                child: Image(
                  image: AssetImage('images/Weather.jpg'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => codyPage()));
                },
                child: Image(
                  image: AssetImage('images/Cody.jpg'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => framePage()));
                },
                child: Image(
                  image: AssetImage('images/Frame 5.jpg'),
                ),
              ),
            ),
          ],
        )),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('drawer Header')),
            ListTile(
              title: Text('test1'),
            ),
            ListTile(
              title: Text('test2'),
            )
          ],
        ),
      ),
    );
  }
}
