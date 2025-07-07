import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtest/gorouter%E7%94%A8%E6%B3%95/router/app_route.dart';

import '../../3.0StateNotifierProvider.dart';
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
          onPressed: () {
            //  context.push(loginRouterName);
            //  context.pushReplacement(loginRouterName,extra: "我是第一个页面过的参数"); //相当于getx的 ..off
            final user = User(name: 'John', age: 30);
            context.push(loginRouterName, extra: user); //跳转并带参数

            //其它传参 queryParameters 
            // context.goNamed('detail', queryParameters: {'name': 'John'});
            //   builder: (context, state) {
            //   final String? name = state.queryParameters['name'];
            //   return DetailScreen(name: name);
            // },

          },
          child: Text("Go to the Details screen"),
        ),
      ),
    );
  }
}


