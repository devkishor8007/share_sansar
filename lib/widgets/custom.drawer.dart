import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';
// import 'package:go_router/go_router.dart';

import '../pages/profile/profile.dart';
import '../pages/unknown-friend/unknown_friends.dart';
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
          DrawerHeader(
            decoration: const BoxDecoration(
              // color: Colors.indigo,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1680000827936-e5f64dedb249?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDV8Q0R3dXdYSkFiRXd8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                ),
              ),
            ),
            child: CustomText(
              text: 'POST WALL',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            ),
          ),
          ListTile(
            title: const CustomText(text: 'Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              context.go('/home');
            },
          ),
          ListTile(
            title: const CustomText(text: 'Feeds'),
            leading: const Icon(Icons.timeline_rounded),
            onTap: () {
              context.go('/feeds');
            },
          ),
          ListTile(
            title: const CustomText(text: 'Profile'),
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
              title: const CustomText(text: 'Friends'),
              leading: const Icon(Icons.people),
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
            title: const CustomText(text: 'Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await auth.logout().then(
                (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: CustomText(text: '$value'),
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
