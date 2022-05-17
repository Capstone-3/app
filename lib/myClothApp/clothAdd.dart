import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'cloth.dart';

class ClothAddPage extends StatefulWidget {
  final DatabaseReference reference;

  ClothAddPage(this.reference);

  @override
  State<ClothAddPage> createState() => _ClothAddPageState();
}

class _ClothAddPageState extends State<ClothAddPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;
  XFile? _pickedFile;
  final ImagePicker _imagePicker = ImagePicker();
  final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 옷 추가'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  fillColor: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: _pickedFile == null
                    ? TextField(
                        controller: contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 100,
                        decoration: InputDecoration(labelText: '이미지'),
                      )
                    : Image(image: FileImage(File(_pickedFile!.path))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    child: Icon(Icons.camera_alt),
                  ),
                  MaterialButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: Icon(Icons.image),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () async {
                  Reference? imagesRef = storageRef.child(
                      "images/${DateTime.now().millisecondsSinceEpoch}.jpeg.");
                  await imagesRef.putFile(File(_pickedFile!.path));
                  final imageUrl = await imagesRef.getDownloadURL();
                  widget.reference
                      .push()
                      .set(Cloth(
                        titleController!.value.text,
                        imageUrl,
                        DateTime.now().toIso8601String(),
                      ).toJson())
                      .then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: Text('저장하기'),
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.pickImage(source: imageSource);
    setState(() {
      _pickedFile = pickedFile;
    });
  }
}
