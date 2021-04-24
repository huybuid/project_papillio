import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_papillio/models/user.dart';

class UserServices {
  final String uid;

  UserServices({this.uid});

  final CollectionReference appUserCollection =
  FirebaseFirestore.instance.collection('AppUser');

  Future createUserData( String firstName, String lastName, String phoneNum,
      String job, String workplace, String profilePhoto, String role, String status) async {
    return await appUserCollection.doc(uid).set({
      'uid': uid,
      'firstname': firstName,
      'lastname': lastName,
      'phonenum': phoneNum,
      'job': job,
      'workplace': workplace,
      'profilephoto' :profilePhoto,
      'role': role,
      'status': status,
    });
  }

  Future updateUserData( String firstName, String lastName, String phoneNum,
      String job, String workplace) async {
    return await appUserCollection.doc(uid).update({
      'firstname': firstName,
      'lastname': lastName,
      'phonenum': phoneNum,
      'job': job,
      'workplace': workplace,
    });
  }

  Future updateUserProfilePhoto(String profilePhoto) async {
    return await appUserCollection.doc(uid).update({
      'profilephoto': profilePhoto
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.data()['uid'],
      firstName: snapshot.data()['firstname'] ?? '',
      lastName: snapshot.data()['lastname'] ?? '',
      phoneNum: snapshot.data()['phonenum'] ?? '',
      job: snapshot.data()['job'] ?? '',
      workplace: snapshot.data()['workplace'] ?? '',
      profilePhoto: snapshot.data()['profilephoto'] ?? '',
      role: snapshot.data()['role'] ?? '',
      status: snapshot.data()['status'],
    );
  }

  Stream<UserData> get appUserData {
    return appUserCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}