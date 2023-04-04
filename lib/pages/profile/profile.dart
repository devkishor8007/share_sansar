import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/widgets/custom.appbar.dart';
import 'package:post_wall/widgets/custom.text.dart';
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
    final dataIsProfile = ref.watch(futureProvider);
    Size size = MediaQuery.of(context).size;
    // print(widget.data!.uid);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(appBarText: 'Profile'),
      body: dataIsProfile.when(
          data: (abc) {
            Map<String, dynamic> data = abc!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        17,
                      ),
                    ),
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: data['name'],
                          ),
                          CustomText(
                            text: data['email'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stac) => Text(" $error $stac"),
          loading: () => const LinearProgressIndicator()),
    );
  }
}
