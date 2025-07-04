import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtest/gorouter%E7%94%A8%E6%B3%95/app_route.dart';

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
            child: Container(width: 20, height: 20, 
            color: Colors.pink, child: IconButton(onPressed: () {}, icon: const Icon(Icons.alarm), iconSize: 20, padding: EdgeInsets.zero)),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
        // backgroundColor: Colors.transparent,
      ),
      body: ElevatedButton(
       onPressed: () => context.go('/details'),
        child: Text("Go to the Details screen"),
      ),
    );
  }
}
