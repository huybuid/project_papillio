import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_papillio/models/quote_item.dart';
import 'package:project_papillio/models/user.dart';

class QuoteServices {
  final String uid;

  QuoteServices({this.uid});

  final CollectionReference quoteItemCollection =
  FirebaseFirestore.instance.collection('QuoteItem');

  Future createQuoteItem(String id, String uid, String content, String source,
      Timestamp timeCreated, String status) async {
    return await quoteItemCollection.doc(id).set({
      'id': id,
      'uid': uid,
      'content': content,
      'source': source,
      'timecreated': timeCreated,
      'status': status,
    });
  }

  List<QuoteItem> _quoteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => QuoteItem(
      id: doc.data()['id'],
      uid: doc.data()['uid'],
      content: doc.data()['content'],
      source: doc.data()['source'],
      timeCreated: doc.data()['timecreated'],
      status: doc.data()['status'])
    ).toList();
  }


  Stream<List<QuoteItem>> get quoteListData {
    return quoteItemCollection.snapshots().map(_quoteListFromSnapshot);
  }
}
