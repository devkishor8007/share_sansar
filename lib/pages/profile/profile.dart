import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_sansar/widgets/custom.appbar.dart';
import 'package:share_sansar/widgets/custom.border.dart';
import '../../riverpod/auth_riverpod.dart';
import '../../riverpod/user_riverpod.dart';
import '../../widgets/custom.drawer.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final User? data;
  const ProfilePage({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authServiceProvider);
    final dataIsProfile = ref.watch(futureProvider(auth.user!.uid));
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(appBarText: 'Profile'),
      body: dataIsProfile.when(
          data: (abc) {
            Map<String, dynamic> data = abc.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidgetPage(
                  data: data,
                )
              ],
            );
          },
          error: (error, stackTrace) => Text(" $error"),
          loading: () => const LinearProgressIndicator()),
    );
  }
}
