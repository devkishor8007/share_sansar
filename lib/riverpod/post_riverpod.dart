import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/data/models/post.model.dart';
import 'package:post_wall/data/services/post_service.dart';

final postRiverpod = Provider<PostService>((ref) => PostService());
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final postStreamRiverpod = StreamProvider.autoDispose
    .family<QuerySnapshot<Map<String, dynamic>>, String>((ref, userId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('posts')
      .where('postBy', isEqualTo: userId)
      .snapshots();
});

final feedsPostStreamRiverpod =
    StreamProvider.autoDispose<List<PostModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('posts')
      .orderBy('date', descending: true)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final post = PostModel.fromJson(doc);
      return post;
    }).toList();
  });
});