import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_sansar/riverpod/auth_riverpod.dart';
import 'package:share_sansar/utils/color.dart';
import 'custom.text.dart';

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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/drawer-image.png'),
              ),
            ),
            child: CustomText(
              text: 'POST WALL',
              color: AppColor.whiteColor,
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
              final data = auth.user;
              context.go("/profile", extra: data);
            },
          ),
          ListTile(
              title: const CustomText(text: 'Unknown Friends'),
              leading: const Icon(Icons.people),
              onTap: () {
                context.go('/unknown-friends');
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
