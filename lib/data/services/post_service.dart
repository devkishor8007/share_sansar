import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_wall/data/models/post.model.dart';

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
}
