import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

import 'myClothApp/tab/acc.dart';
import 'myClothApp/tab/all.dart';
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
  XFile? _pickedFile;
  String? _downloadURL;
  TabController? _tabController;
  final ImagePicker _imagePicker = ImagePicker();
  final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    _tabController = new TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 옷'),
        bottom: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Text('전체'),
            ),
            Tab(
              icon: Text('아우터'),
            ),
            Tab(
              icon: Text('상의'),
            ),
            Tab(
              icon: Text('하의'),
            ),
            Tab(
              icon: Text('신발'),
            ),
            Tab(
              icon: Text('악세사리'),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          _pickedFile == null
              ? all()
              : Column(
                  children: [
                    Image.file(File(_pickedFile!.path)),
                    Text('${_downloadURL}'),
                  ],
                ),
          top(),
          outer(),
          pants(),
          shoes(),
          acc(),
        ],
        controller: _tabController,
      ),
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            onTap: () {
              pickImage(ImageSource.camera);
            },
            child: Icon(Icons.photo_camera),
          ),
          SpeedDialChild(
            onTap: () {
              pickImage(ImageSource.gallery);
            },
            child: Icon(Icons.image),
          )
        ],
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.pickImage(source: imageSource);
    Reference? imagesRef = storageRef
        .child("images/${DateTime.now().millisecondsSinceEpoch}.jpeg.");
    await imagesRef.putFile(File(pickedFile!.path));
    final downloadURL = await imagesRef.getDownloadURL();
    setState(() {
      _pickedFile = pickedFile;
      _downloadURL = downloadURL;
    });
  }
}
