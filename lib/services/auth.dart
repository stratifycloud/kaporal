import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaporal/services/constants.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get user {
    return _auth.authStateChanges().map((User? user) => user);
  }

  // sign in with email&password
  static Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // user will be stored locally
      User? user = result.user;
      if (user != null && user.email != null) {
        // IsarUser? isarUser = await SqlService.getUser(user.uid);
        // if (isarUser == null) {
        //   throw FirebaseAuthException(code: 'sql-error');
        // }
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'An user with this e-mail/password was not found.';
        default:
        return 'There was a problem trying to sign you in.';
      }
    }
    return "success";
  }

  // register in with email&password
  static Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(Constants.timeoutDuration);
      // user will be saved in provider
      User? user = result.user;
      if (user != null && user.email != null) {
        try {
          // await SqlService.addUserToDatabase(
          //     user.uid, user.email!, false, '', '', '', '', '');
        } catch (e) {
          await user.delete();
          return 'Registration failed';
        }
        return "success";
      } else {
        return 'Registration failed';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak password';
      } else if (e.code == 'email-already-in-use') {
        return 'This e-mail is already in use!';
      }
    } catch (e) {
      return e.toString();
    }
    return "success";
  }

  // sign-out
  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}