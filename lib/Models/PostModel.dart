import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String title = "제목이 없습니다.";
  List<dynamic>? tag;
  List<dynamic>? images = [];
  String post = "";
  String writer = "";
  String id = "";
  String writerNickname = "";
  List<dynamic> drop = [];
  int views = 0;
  List<dynamic> comments = [];
  bool updated = false;
  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    title = documentSnapshot.get("title");
    tag = documentSnapshot.get("tag");
    images = documentSnapshot.get("images");
    post = documentSnapshot.get("post");
    writer = documentSnapshot.get("writer");
    writerNickname = documentSnapshot.get("writernickname");
    id = documentSnapshot.id;
    views = documentSnapshot.get("view");
    drop = documentSnapshot.get("drop");
    comments = documentSnapshot.get("comment");
    updated = documentSnapshot.get("updated");
  }
}
