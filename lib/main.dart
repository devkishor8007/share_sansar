import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_sansar/app.dart';
import 'package:share_sansar/firebase_options.dart';
import 'package:share_sansar/utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final firebaseInitProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: goRouter,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}

class FirebaseInitializeRoute extends ConsumerWidget {
  const FirebaseInitializeRoute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializeFirebase = ref.watch(firebaseInitProvider);
    return initializeFirebase.when(
      data: (data) {
        return const AuthCheck();
      },
      error: (error, stackTrace) => Text('$error'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
