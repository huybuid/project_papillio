import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteItem {
  String id;
  String uid;
  String content;
  String source;
  Timestamp timeCreated;
  String status;

  QuoteItem({this.id, this.uid, this.content, this.source, this.timeCreated, this.status});
}