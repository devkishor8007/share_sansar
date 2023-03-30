import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

import '../riverpod/auth_riverpod.dart';
import '../widgets/custom.drawer.dart';

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
      drawer: CustomDrawer(
        auth: auth,
      ),
    );
  }
}
