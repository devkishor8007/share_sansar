import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/app.dart';
import 'package:post_wall/firebase_options.dart';
import 'package:post_wall/pages/auth/signup.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final firebaseInitProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializeFirebase = ref.watch(firebaseInitProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: initializeFirebase.when(
        data: (data) {
          return const AuthCheck();
        },
        error: (e, stackTrace) => Text('$e $stackTrace'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
