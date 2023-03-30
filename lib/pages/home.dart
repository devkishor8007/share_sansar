import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:post_wall/pages/profile/profile.dart';

import '../riverpod/auth_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  // final String uid;
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('welcome'),
      ),
      drawer: Drawer(
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
                  final data = auth.user;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProfilePage(data: data),
                    ),
                  );
                }),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                final data = await auth.logout();

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
      ),
    );
  }
}
