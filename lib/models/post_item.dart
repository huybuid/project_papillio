import 'package:cloud_firestore/cloud_firestore.dart';

class PostItem {
  String id;
  String uid;
  String content;
  String photo;
  Timestamp timeCreated;
  String status;

  PostItem({this.id, this.uid, this.content, this.photo, this.timeCreated, this.status});
}