import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_papillio/models/to_do_item.dart';

class ToDoListServices {
  final String uid;
  ToDoListServices({this.uid});
  
  final CollectionReference toDoListCollection =
  FirebaseFirestore.instance.collection('ToDoList');

  Future updateToDoList(String id, String name, Timestamp timeToDo, Timestamp timeExecuted, Timestamp timeCreated, String status) async {
    return await toDoListCollection.doc(id).set({
      'id': id,
      'uid': uid,
      'name': name,
      'timetodo': timeToDo,
      'timeexecuted': timeExecuted,
      'timecreated': timeCreated,
      'status': status,
    });
  }

  Future executeToDoList(String id, Timestamp timeExecuted, String status) async {
    return await toDoListCollection.doc(id).update({
      'timeexecuted': timeExecuted,
      'status': status,
    });
  }

  Future deleteToDoList(String id) async {
    return await toDoListCollection.doc(id).delete();
  }

  List<ToDoItem> _toDoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ToDoItem(
        id: doc.data()['id'],
        uid: doc.data()['uid'],
        name: doc.data()['name'] ?? 'Unnamed task',
        timeToDo: doc.data()['timetodo'] ?? null,
        timeExecuted: doc.data()['timeexecuted'] ?? null,
        timeCreated: doc.data()['timecreated'],
        status: doc.data()['status'],);
    }).toList();
  }

  Stream<List<ToDoItem>> get toDoListData {
    try {
      return toDoListCollection.where('uid', isEqualTo: this.uid).orderBy('timetodo', descending: false).snapshots().map(_toDoListFromSnapshot);
    }
    catch (e) {
      return null;
    }
  }
  
}