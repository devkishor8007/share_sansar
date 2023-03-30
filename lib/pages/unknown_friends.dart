import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/riverpod/user_riverpod.dart';

import '../riverpod/auth_riverpod.dart';
import '../widgets/custom.drawer.dart';

class UnKnownFriendPage extends ConsumerStatefulWidget {
  // final String uid;
  const UnKnownFriendPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnKnownFriendPageState();
}

class _UnKnownFriendPageState extends ConsumerState<UnKnownFriendPage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authServiceProvider);
    final otherFriends = ref.watch(userStreamRiverpod);
    return Scaffold(
      appBar: AppBar(
        title: const Text('friend'),
      ),
      drawer: CustomDrawer(
        auth: auth,
      ),
      body: otherFriends.when(
        data: (data) {
          if (data.docs.isEmpty) {
            return const Center(child: Text("no"));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text(data.docs[index]['email']);
            },
            itemCount: data.docs.length,
          );
        },
        error: (error, stac) => Text(" $error $stac"),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
