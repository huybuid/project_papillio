import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoItem {
  String id;
  String uid;
  String name;
  Timestamp timeToDo;
  Timestamp timeExecuted;
  Timestamp timeCreated;
  String status;

  ToDoItem({
    this.id,
    this.uid,
    this.name,
    this.timeToDo,
    this.timeExecuted,
    this.timeCreated,
    this.status,
});
}