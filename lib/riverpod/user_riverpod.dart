import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';

import '../data/services/user_service.dart';

final userRiverpod = Provider<UserService>((ref) => UserService());

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final futureProvider =
    FutureProvider.autoDispose<DocumentSnapshot<Map<String, dynamic>>?>(
        (ref) async {
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authServiceProvider);
  return await firestore.collection('user').doc(auth.user!.uid).get();
});

final userStreamRiverpod = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('user').snapshots();
});
