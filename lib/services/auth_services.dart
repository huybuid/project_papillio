import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_papillio/services/user_services.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user =>_auth.authStateChanges();

  Future SignInAnon() async {
    try{
      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      //AppUser appUser = _user(credential.user);
    }
    on FirebaseAuthException catch  (e) {
      return null;
    } catch (e) {
      print(e);
    }
  }

  Future SignInWithEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = credential.user;
      return null;
    }
    catch (e) {
      return 'Incorrect email or password';
    }
  }

  Future SignUpWithEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user;
      await UserServices(uid: user.uid).createUserData(null,null,null,null,
          null,null,'u','a');
      return user;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future SignOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {

    }
  }

  Future SendPasswordReset(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch (e) {

    }
  }
}