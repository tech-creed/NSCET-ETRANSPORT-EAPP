import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance.reference();

  // Auth change user stream
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Stream<User?> get user => _auth.userChanges();

  // Register with email and passord
  Future register(email, password, name, role, dept, regno) async {
    final userDb = database.child("/users");
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      DatabaseReference push = userDb.push();
      push.set({
        'user_id': userCredential.user!.uid,
        'email': email,
        'name': name,
        'role': role,
        'dept': dept,
        'regno': regno,
        'assigned_role': " ",
        'trackerID': " ",
        'stop': " ",
        'route': " ",
      });

      return null;
    } catch (e) {
      return e;
    }
  }

  // Signin with email and password
  Future signIn(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return null;
    } catch (e) {
      return e;
    }
  }

  // Sign out of current user
  void signOut() {
    _auth.signOut();
  }

  //Reset Password
  Future sendPasswordResetEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return e;
    }
  }

  //Verify email
  Future sendVerificationEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      return null;
    } catch (e) {
      return e;
    }
  }
}
