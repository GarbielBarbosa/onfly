import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/firebase_options.dart';
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
    redirect: (BuildContext context, GoRouterState state) async {
      if (FirebaseAuth.instance.currentUser == null) {
        return '/Login';
      } else {
        return '/HomePage';
      }
    });

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<User?> _subscription;

  GoRouterRefreshStream(Stream<User?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
