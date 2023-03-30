import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/profile/profile.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  final dynamic auth;
  const CustomDrawer({super.key, required this.auth});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer header'),
          ),
          ListTile(
              title: const Text('Profile'),
              leading: const Icon(Icons.person),
              onTap: () {
                //  context.go('/');
                final data = widget.auth.user;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage(data: data),
                  ),
                );
              }),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              final data = await widget.auth.logout();

              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$data'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
