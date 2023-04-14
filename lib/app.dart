import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_sansar/pages/home.dart';
import 'package:share_sansar/pages/auth/login.page.dart';
import 'package:share_sansar/riverpod/auth_riverpod.dart';

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
      error: (error, stackTrace) => Text('$error'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
