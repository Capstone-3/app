import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../cloth.dart';
import '../clothAdd.dart';
import '../clothDetail.dart';

class acc extends StatefulWidget {
  @override
  State<acc> createState() => _accState();
}

class _accState extends State<acc> {
  final reference = FirebaseDatabase.instance.ref().child('acc');
  List<Cloth> clothes = new List.empty(growable: true);

  @override
  void initState() {
    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        clothes.add(Cloth.fromSnapshot(event.snapshot, data));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        color: Color.fromRGBO(239, 238, 245, 100),
        child: Center(
          child: clothes.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: GridTile(
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async {
                                Cloth? cloth = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ClothDetailPage(
                                                reference, clothes[index])));
                                if (cloth != null) {
                                  setState(() {
                                    clothes[index].title = cloth.title;
                                    clothes[index].imageUrl = cloth.imageUrl;
                                  });
                                }
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('삭제하시겠습니까?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              reference
                                                  .child(clothes[index].key!)
                                                  .remove()
                                                  .then((_) {
                                                setState(() {
                                                  clothes.removeAt(index);
                                                  Navigator.of(context).pop();
                                                });
                                              });
                                            },
                                            child: Text('예'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니요'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Image.network(clothes[index].imageUrl),
                            ),
                          ),
                        ),
                        header: Text(clothes[index].title,
                            textAlign: TextAlign.center),
                        footer: Text(
                          clothes[index].createTime.substring(0, 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  itemCount: clothes.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(112, 125, 222, 100),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ClothAddPage(reference)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
