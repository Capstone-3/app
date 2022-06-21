import 'package:firebase_database/firebase_database.dart';

class Cloth {
  String? key;
  String title;
  String content;
  String imageUrl;
  String createTime;

  Cloth(this.title, this.content, this.imageUrl, this.createTime);

  Cloth.fromSnapshot(DataSnapshot snapshot, Map<String, dynamic> map)
      : key = snapshot.key,
        title = map['title'],
        content = map['content'],
        imageUrl = map['imageUrl'],
        createTime = map['createTime'];

  toJson() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createTime': createTime,
    };
  }
}
