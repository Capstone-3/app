import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'clothManagementPage.dart';
import 'firebase_options.dart';
import 'homePage.dart';
import 'myClosetPage.dart';
import 'myClothPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          homeApp(),
          myClothApp(),
          myClosetApp(),
          clothManagementApp()
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Column(
              children: [
                Icon(Icons.home),
                Text('홈'),
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: [
                Icon(Icons.home),
                Text('내 옷'),
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: [
                Icon(Icons.home),
                Text('내 옷장'),
              ],
            ),
          ),
          Tab(
            icon: Column(
              children: [
                Icon(Icons.home),
                Text('옷 관리'),
              ],
            ),
          ),
        ],
        controller: _tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}
