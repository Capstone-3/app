import 'package:flutter/material.dart';

import 'clothManagementPage/codyPage.dart';
import 'clothManagementPage/framePage.dart';

class clothManagementApp extends StatelessWidget {
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
                  image: AssetImage('images/Frame 41.jpg'),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
