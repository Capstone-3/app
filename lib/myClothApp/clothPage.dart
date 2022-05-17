import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'cloth.dart';
import 'clothAdd.dart';
import 'clothDetail.dart';

class ClothPage extends StatefulWidget {
  @override
  State<ClothPage> createState() => _ClothPageState();
}

class _ClothPageState extends State<ClothPage> {
  final reference = FirebaseDatabase.instance.ref().child('cloth');
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
      appBar: AppBar(
        title: Text('내 옷'),
      ),
      body: Container(
        child: Center(
          child: clothes.length == 0
              ? CircularProgressIndicator()
              : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Card(
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
                        child: Image(
                          image: NetworkImage(clothes[index].imageUrl),
                        ),
                      ),
                    ),
                  ),
                  header: Text(clothes[index].title),
                  footer: Text(clothes[index].createTime.substring(0, 10)),
                ),
              );
            },
            itemCount: clothes.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ClothAddPage(reference)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
