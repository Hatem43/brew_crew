import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/modules/user.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebaseuser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    //map authentication changes every time user signed in  to our custom user or return null if he signed out
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future SignInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signinwithemailandpassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password); // this will create user with email and password
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user); //  if it successes ,it will return custom user based on our user module
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }
    //Register with email and password

    Future registerwithemailandpassword(String email, String password) async {
      try {
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); // this will create user with email and password
        FirebaseUser user = result.user;

        //create a new document for the user with uid
        await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
        return _userFromFirebaseUser(user); //  if it successes ,it will return custom user based on our user module
      }
      catch (e) {
        print(e.toString());
        return null;
      }
    }
    // sign out
    Future signOut() async {
      try {
        return await _auth.signOut();
      }
      catch (e) {
        print(e.toString());
        return null;
      }
    }
}