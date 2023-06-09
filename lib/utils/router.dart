import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_sansar/app.dart';
import 'package:share_sansar/pages/feeds.dart';
import 'package:share_sansar/pages/home.dart';
import 'package:share_sansar/main.dart';
import 'package:share_sansar/pages/auth/login.page.dart';
import 'package:share_sansar/pages/auth/signup.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_sansar/pages/unknown-friend/unknown_friends.dart';
import '../pages/profile/profile.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const FirebaseInitializeRoute(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) =>
          const SignupPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
    GoRoute(
      path: '/check-auth',
      builder: (BuildContext context, GoRouterState state) => const AuthCheck(),
    ),
    GoRoute(
      path: '/feeds',
      builder: (BuildContext context, GoRouterState state) =>
          const FeedsScreen(),
    ),
    GoRoute(
      path: '/unknown-friends',
      builder: (BuildContext context, GoRouterState state) =>
          const UnKnownFriendPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) => ProfilePage(
        data: state.extra as User,
      ),
    ),
  ]);
});
