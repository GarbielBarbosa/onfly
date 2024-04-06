import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/modules/home/pages/home/home_page.dart';
import 'package:onfly/shared/widgets/bottom_navigation_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final List<RouteBase> homeRoutes = <RouteBase>[
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
          child: ScaffoldWithNavBar(
        // location: state.location,
        child: child,
      ));
    },
    routes: [
      GoRoute(
        path: '/HomePage',
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: HomePage(),
          );
        },
      ),
      GoRoute(
        path: '/discover',
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: Scaffold(
              body: Center(child: Text("Discover")),
            ),
          );
        },
      ),
      GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/shop',
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: Text("Shop")),
              ),
            );
          }),
    ],
  ),
];
