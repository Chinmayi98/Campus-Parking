import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing/models/user.dart';
import 'package:testing/services/database.dart';

 class AuthService {

   final FirebaseAuth _auth = FirebaseAuth.instance;

   // Create User object based on firebase user
   User _userFromFirebaseUser(FirebaseUser user) {
     return user != null ? User(uid: user.uid) : null;
   }

   // Auth change user stream
   Stream<User> get user {
     return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
   }

   // Sign in Anonymously
   Future signInAnon() async {
     try {
       AuthResult result = await _auth.signInAnonymously();
       FirebaseUser user = result.user;
       return _userFromFirebaseUser(user);
     } catch(e) {
       print(e.toString());
       return null;
     }
   }

   // Sign in with email and password
   Future signInWithEmailAndPassword(String _emailId, String _password) async {
     try {
       AuthResult result = await _auth.signInWithEmailAndPassword(email: _emailId, password: _password);
       FirebaseUser user = result.user;
       return _userFromFirebaseUser(user);
     } catch(e) {
       print(e.toString());
       return null;
     }
   }

   // Register with email and password
   Future registerWithEmailAndPassword(String _emailId, String _password) async {
     try {
       AuthResult result = await _auth.createUserWithEmailAndPassword(email: _emailId, password: _password);
       FirebaseUser user = result.user;

       // Creating a new document for the user with uid
       await DatabaseService(uid: user.uid).updateUserData('default', 'default');
       return _userFromFirebaseUser(user);
     } catch(e) {
       print(e.toString());
       return null;
     }
   }

   // Sign out
   Future signOut() async {
     try {
       return await _auth.signOut();
     } catch(e) {
       print(e.toString());
       return null;
     }
   }
}