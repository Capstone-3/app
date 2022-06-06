import 'package:flutter/material.dart';

import 'home/codyPage.dart';
import 'home/framePage.dart';
import 'home/weather.dart';

class homeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Hicloset',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
                  image: AssetImage('images/Weather.jpg'),
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
                  image: AssetImage('images/Cody.jpg'),
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
    );
  }
}
