import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/data/services/post_service.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';

final postRiverpod = Provider<PostService>((ref) => PostService());
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final postStreamRiverpod = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authServiceProvider);
  final userId = auth.user!.uid.toString();
  return firestore
      .collection('posts')
      .where('postBy', isEqualTo: userId)
      .snapshots();
});
