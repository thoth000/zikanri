import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> createUser(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user.uid;
    } catch (error) {
      if (error.toString() ==
          '[firebase_auth/invalid-email] The email address is badly formatted.') {
        return 'error:email';
      }
      if (error.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        return 'error:exist';
      }
      print(error);
      return 'error:unknown';
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user.uid;
    } catch (error) {
      print(error);
      if (error.toString() ==
              '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.' ||
          error.toString() ==
              '[firebase_auth/invalid-email] The email address is badly formatted.') {
        return 'error:email';
      }
      if (error.toString() ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        return 'error:password';
      }
      return 'error:unknown';
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
