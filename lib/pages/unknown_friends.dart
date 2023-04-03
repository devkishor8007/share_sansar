import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_wall/riverpod/user_riverpod.dart';
import 'package:post_wall/widgets/custom.appbar.dart';
import '../widgets/custom.drawer.dart';

class UnKnownFriendPage extends ConsumerStatefulWidget {
  // final String uid;
  const UnKnownFriendPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UnKnownFriendPageState();
}

class _UnKnownFriendPageState extends ConsumerState<UnKnownFriendPage> {
  @override
  Widget build(BuildContext context) {
    final otherFriends = ref.watch(userStreamRiverpod);
    return Scaffold(
      appBar: const CustomAppBar(appBarText: 'UnKnown-Friend'),
      drawer: const CustomDrawer(),
      body: otherFriends.when(
        data: (data) {
          if (data.docs.isEmpty) {
            return const Center(child: Text("0 Unknown Friends"));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  data.docs[index]['email'],
                  style: GoogleFonts.lato(),
                ),
              );
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
