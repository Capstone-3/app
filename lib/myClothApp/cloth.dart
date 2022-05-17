import 'package:firebase_database/firebase_database.dart';

class Cloth {
  String? key;
  String title;
  String imageUrl;
  String createTime;

  Cloth(this.title, this.imageUrl, this.createTime);

  Cloth.fromSnapshot(DataSnapshot snapshot, Map<String, dynamic> map)
      : key = snapshot.key,
        title = map['title'],
        imageUrl = map['imageUrl'],
        createTime = map['createTime'];

  toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'createTime': createTime,
    };
  }
}
