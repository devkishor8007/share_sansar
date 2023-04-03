import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';
// import 'package:go_router/go_router.dart';

import '../pages/profile/profile.dart';
import '../pages/unknown_friends.dart';
import 'custom.text.dart';
// import '../pages/profile/profile.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authServiceProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: CustomText(text:'Drawer header'),
          ),
          ListTile(
            title: const CustomText(text:'Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              context.go('/home');
            },
          ),
          ListTile(
            title: const CustomText(text:'Feeds'),
            leading: const Icon(Icons.timeline_rounded),
            onTap: () {
              context.go('/feeds');
            },
          ),
          ListTile(
            title: const CustomText(text:'Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              //  context.go('/');
              final data = auth.user;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage(data: data),
                ),
              );
            },
          ),
          ListTile(
              title: const CustomText(text:'Friends'),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const UnKnownFriendPage(),
                  ),
                );
              }),
          ListTile(
            title: const CustomText(text:'Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await auth.logout().then(
                (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: CustomText(text:'$value'),
                    ),
                  );
                  context.go('/check-auth');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
