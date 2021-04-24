import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String postId;
  String uid;
  String content;
  Timestamp timeCreated;
  String status;

  Comment({this.id, this.uid, this.postId, this.content, this.timeCreated, this.status});
}