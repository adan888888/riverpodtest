import 'package:go_router/go_router.dart';
import 'package:riverpodtest/gorouter%E7%94%A8%E6%B3%95/view/main.dart';

import 'app_route_name.dart';
import 'view/second.dart';

GoRouter appRouter = GoRouter(
  initialLocation: homeRouter, //启动页面第一个页面
  routes: <RouteBase>[
    GoRoute(path: homeRouter, builder: (context, state) => MyHomePage()),
    GoRoute(path: loginRouterName, builder: (context, state) => LoginScreen()),
  ],
);
