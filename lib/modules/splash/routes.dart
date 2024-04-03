import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/modules/splash/splash_page.dart';

final List<RouteBase> splashRoutes = <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const SplashPage();
    },
    routes: const <RouteBase>[],
  ),
];
