import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/data/home.dart';
import 'package:post_wall/pages/auth/login.page.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';

class AuthCheck extends ConsumerWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) return const HomePage();
        return const LoginPage();
      },
      error: (e, stackTrace) => Text('$e $stackTrace'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
