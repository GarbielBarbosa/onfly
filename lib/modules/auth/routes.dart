import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/modules/auth/pages/login/login_page.dart';

final List<RouteBase> loginRoutes = <RouteBase>[
  GoRoute(
    path: '/Login',
    builder: (BuildContext context, GoRouterState state) {
      return const Login();
    },
    routes: <RouteBase>[],
  ),
];
