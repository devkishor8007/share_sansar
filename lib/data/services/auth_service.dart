import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  User? get user => auth.currentUser;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<String?> createAccount(
      {required String email, required String password, required String username}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password );
        await user!.updateDisplayName(username);
      return 'Thank you for signing up';
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (error.code == 'email-already-in-use') {
        return "The account already exists for that email";
      }
      return error.message;
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> loginAccount(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return 'You have successfully logged in!';
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        return 'Wrong password provided for that user';
      }
      return error.message;
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> logout() async {
    try {
      await auth.signOut();
      return "You have successfully logged out";
    } on FirebaseAuthException catch (error) {
      return error.message;
    } catch (error) {
      rethrow;
    }
  }
}
