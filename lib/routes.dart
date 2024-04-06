import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/modules/home/routes.dart';
import 'package:onfly/modules/splash/routes.dart';
import 'modules/auth/routes.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    ...splashRoutes,
    ...loginRoutes,
    ...homeRoutes,
  ],
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
);

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<User?> _subscription;

  GoRouterRefreshStream(Stream<User?> stream) {
    _subscription = stream.listen((_) {
      _handleAuthStateChange();
    });
  }

  void _handleAuthStateChange() {
    if (FirebaseAuth.instance.currentUser == null) {
      router.go('/Login');
    } else {
      router.go('/HomePage');
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
