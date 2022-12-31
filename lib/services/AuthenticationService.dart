import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/userModel.dart';
import 'package:messaging_app/services/DatabaseService.dart';

class AuthService {
  // FirebaseApp fApp = Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // final FirebaseAuth _auth = FirebaseAuth.instanceFor(app: fApp);

  //auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in with email password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for the user with uid
      await Database(uid:user!.uid).updateUserData('');

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
