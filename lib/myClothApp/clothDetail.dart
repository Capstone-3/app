import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'cloth.dart';

class ClothDetailPage extends StatefulWidget {
  final DatabaseReference reference;
  final Cloth cloth;

  ClothDetailPage(this.reference, this.cloth);

  @override
  State<ClothDetailPage> createState() => _ClothDetailPageState();
}

class _ClothDetailPageState extends State<ClothDetailPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.cloth.title);
    contentController = TextEditingController(text: widget.cloth.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cloth.title),
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
                child: Image(image: NetworkImage(widget.cloth.imageUrl)),
              ),
              MaterialButton(
                onPressed: () {
                  Cloth cloth = Cloth(titleController!.value.text,
                      contentController!.value.text, widget.cloth.createTime);
                  widget.reference
                      .child(widget.cloth.key!)
                      .set(cloth.toJson())
                      .then((_) {
                    Navigator.of(context).pop(cloth);
                  });
                },
                child: Text('수정하기'),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
