import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_sansar/riverpod/auth_riverpod.dart';

import '../data/services/user_service.dart';

final userRiverpod = Provider<UserService>((ref) => UserService());

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final futureProvider = FutureProvider.autoDispose
    .family<DocumentSnapshot<Map<String, dynamic>>, String>(
        (ref, userId) async {
  final firestore = ref.watch(firestoreProvider);
  return await firestore.collection('user').doc(userId).get();
});

final userStreamRiverpod = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authServiceProvider);
  final userId = auth.user!.uid;
  return firestore
      .collection('user')
      .where('uid', isNotEqualTo: userId.toString())
      .snapshots();
});
