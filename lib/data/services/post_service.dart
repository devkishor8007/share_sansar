import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  static final CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('posts');

  Future<String?> createPost({
    required String id,
    required String title,
    required String postBy,
    required String description,
  }) async {
    try {
      await firebaseFirestore.doc(id).set({
        'postBy': postBy,
        'title': title,
        'description': description,
        'date': Timestamp.now(),
        'id': id,
      });
      return 'created';
    } catch (error) {
      return "error";
    }
  }
}
