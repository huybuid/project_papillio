import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_papillio/models/post_item.dart';
import 'package:project_papillio/models/comment.dart';

class PostServices {
  final String uid;
  final String id;

  PostServices({this.uid, this.id});

  final CollectionReference postItemCollection =
  FirebaseFirestore.instance.collection('PostItem');

  final CollectionReference commentItemCollection =
  FirebaseFirestore.instance.collection('Comment');

  Future createPostItem(String id, String uid, String content, String photo,
      Timestamp timeCreated, String status) async {
    return await postItemCollection.doc(id).set({
      'id': id,
      'uid': uid,
      'content': content,
      'photo': photo,
      'timecreated': timeCreated,
      'status': status,
    });
  }

  Future deletePost(String id) async {
    return await postItemCollection.doc(id).delete();
  }

  Future deleteComment(String id) async {
    return await commentItemCollection.doc(id).delete();
  }

  List<PostItem> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => PostItem(
        id: doc.data()['id'],
        uid: doc.data()['uid'],
        content: doc.data()['content'],
        photo: doc.data()['photo'],
        timeCreated: doc.data()['timecreated'],
        status: doc.data()['status'])
    ).toList();
  }



  Future createComment(String commentId, String content, Timestamp timeCreated,
      String status) async {
    return await commentItemCollection.doc(commentId).set({
      'id': commentId,
      'postid': this.id,
      'uid': this.uid,
      'content': content,
      'timecreated': timeCreated,
      'status': status,
    });
  }

  List<Comment> _commentFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Comment(
        id: doc.data()['id'],
        postId: doc.data()['postid'],
        uid: doc.data()['uid'],
        content: doc.data()['content'],
        timeCreated: doc.data()['timecreated'],
        status: doc.data()['status'])
    ).toList();
  }

  Stream<List<PostItem>> get postListData {
    return postItemCollection.orderBy('timecreated' , descending: true).limit(10).snapshots().map(_postListFromSnapshot);
  }
  
  Stream<List<PostItem>> get postListDataByUid {
    return postItemCollection.where('uid', isEqualTo: this.uid).snapshots().map(_postListFromSnapshot);
  }

  Stream<List<Comment>> get commentListData {
    return commentItemCollection.where('postid', isEqualTo: this.id).snapshots().map(_commentFromSnapshot);
  }
}