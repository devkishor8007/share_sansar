import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/user_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final User? data;
  const ProfilePage({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final dataIsProfile = ref.watch(futureProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data!.uid),
      ),
      body: dataIsProfile.when(
          data: (abc) {
            Map<String, dynamic> data = abc!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['email']),
                Text(data['name']),
              ],
            );
          },
          error: (error, stac) => Text(" $error $stac"),
          loading: () => const CircularProgressIndicator()),
    );
  }
}
