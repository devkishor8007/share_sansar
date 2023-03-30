import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('user');

  Future<bool?> createUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    try {
      await firebaseFirestore.doc(uid).set({
        'name': name,
        'email': email,
        'date': Timestamp.now(),
        'uid': uid,
      });
      return true;
    } catch (error) {
      // print(error);
      return false;
    }
  }

  Future getUser({required String uid}) async {
    final DocumentSnapshot user = await firebaseFirestore.doc(uid).get();
    return user;
  }
}
