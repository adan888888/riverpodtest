import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtest/3.%E8%B7%AF%E7%94%B1%E7%94%A8%E6%B3%95-Gorouter%E7%9A%84%E7%94%A8%E6%B3%95/router/app_route.dart';

import '../../1.状态管理/3.0StateNotifierProvider.dart';
import '../router/app_route_path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('列表'),
        actions: [
          UnconstrainedBox(
            child: Container(width: 20, height: 20, color: Colors.pink, child: IconButton(onPressed: () {}, icon: const Icon(Icons.alarm), iconSize: 20, padding: EdgeInsets.zero)),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
        // backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //  push放  '/home' ; pushName放 name（路由里面配置的name）
            //  context.push(loginRouterName);
            //  context.pushReplacement(loginRouterName); //相当于getx的 ..off

            //第1种： extra: user --对象
            final user = User(name: 'John', age: 30);
            context.push(loginRouterName, extra: user); //跳转并带参数

            //第2种：queryParameters 注意⚠️URL 参数始终是字符串，需手动转换为其他类型（如int.tryParse）
            final queryParams = {
              'id': '123', // 字符串参数
              'name': '张三', // 中文参数
              'isVip': 'true', // 布尔值需转为字符串
            };
            var result =await context.pushNamed("login", queryParameters: queryParams);
            print("第二个页面返回的值 $result");
            print("第二个页面返回的值 ${(result as Map)['timestamp']}"); //取某一个值
           
          },
          child: Text("Go to the Second screen"),
        ),
      ),
    );
  }
}
