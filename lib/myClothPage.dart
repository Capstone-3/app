import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'myClothApp/tab/acc.dart';
import 'myClothApp/tab/outer.dart';
import 'myClothApp/tab/pants.dart';
import 'myClothApp/tab/shoes.dart';
import 'myClothApp/tab/top.dart';

class myClothApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _myClothApp();
}

class _myClothApp extends State<myClothApp>
    with SingleTickerProviderStateMixin {
  final reference = FirebaseDatabase.instance.ref().child('cloth');
  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '내 옷',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          indicator: BoxDecoration(
            color: Color.fromRGBO(112, 125, 222, 100),
          ),
          tabs: <Tab>[
            Tab(
              icon: Text(
                '아우터',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              icon: Text(
                '상의',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              icon: Text(
                '하의',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              icon: Text(
                '신발',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              icon: Text(
                '악세사리',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          top(),
          outer(),
          pants(),
          shoes(),
          acc(),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
  }
}
