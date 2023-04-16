import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_sansar/data/models/post.model.dart';

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
      final PostModel newPostModel = PostModel(
        id: id,
        date: Timestamp.now(),
        description: description,
        title: title,
        postBy: postBy,
      );
      await firebaseFirestore.doc(id).set(newPostModel.toMap());
      return 'created';
    } catch (error) {
      return "error";
    }
  }

  Future<bool> deletePost({required String id}) async {
    try {
      await firebaseFirestore.doc(id).delete();
      return true;
    } catch (error) {
      return false;
    }
  }
}
