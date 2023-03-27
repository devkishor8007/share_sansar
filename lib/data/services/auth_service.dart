import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<String?> createAccount(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Thank you for signing up';
    } on FirebaseAuthException catch (error) {
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
