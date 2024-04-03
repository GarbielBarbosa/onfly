import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/modules/home/pages/home/home_page.dart';

final List<RouteBase> homeRoutes = <RouteBase>[
  GoRoute(
    path: '/HomePage',
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
    routes: <RouteBase>[],
  ),
];
