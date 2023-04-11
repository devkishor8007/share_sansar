import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/pages/unknown-friend/friend_detail.dart';
import 'package:post_wall/riverpod/user_riverpod.dart';
import 'package:post_wall/widgets/custom.appbar.dart';
import '../../widgets/custom.border.dart';
import '../../widgets/custom.drawer.dart';

class UnKnownFriendPage extends ConsumerStatefulWidget {
  const UnKnownFriendPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UnKnownFriendPageState();
}

class _UnKnownFriendPageState extends ConsumerState<UnKnownFriendPage> {
  @override
  Widget build(BuildContext context) {
    final otherFriends = ref.watch(userStreamRiverpod);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(appBarText: 'UnKnown-Friend'),
      drawer: const CustomDrawer(),
      body: otherFriends.when(
        data: (data) {
          if (data.docs.isEmpty) {
            return const Center(child: Text("0 Unknown Friends"));
          }
          return ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    (MaterialPageRoute(
                      builder: (BuildContext context) => UnknownFriendDetail(
                        userId: data.docs[index]['uid'],
                      ),
                    )),
                  );
                },
                child: CustomWidgetPage(
                  data: data.docs[index],
                  height: size.height * 0.13,
                ),

                // ListTile(
                //   title: Text(
                //     data.docs[index]['email'],
                //   ),
                // ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(" $error"),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
