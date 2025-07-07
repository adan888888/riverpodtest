import 'package:go_router/go_router.dart';
import 'package:riverpodtest/gorouter%E7%94%A8%E6%B3%95/view/main.dart';

import 'app_route_path.dart';
import '../view/second.dart';

GoRouter appRouter = GoRouter(
  initialLocation: homeRouter, //启动页面第一个页面
  routes: <RouteBase>[
    GoRoute(path: homeRouter, name: "home",builder: (context, state) => MyHomePage()),//name: "home"这个名字是命名路由的时候使用,context.pushNamed("home")

    GoRoute(
      path: loginRouterName,
      redirect: (context, state) { //拦截：支持 redirect 回调进行导航守卫（如权限验证）。
        //  if (!isLoggedIn) return '/login';
        return null; // 继续导航
      },
      name: "login",
      builder: (context, state) {
        //对象传参数
        // var user = (state.extra as User?);
        // return LoginScreen(user: user);
        
        //  第2种 queryParameters传参,  GoRouterState用于解析 queryParameters
        return LoginScreen(state:state);
      },
    ),
  ],
);
