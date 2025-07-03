import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
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
            child: Container(
              width: 20,
              height: 20,
              color: Colors.pink,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.alarm), iconSize: 20, padding: EdgeInsets.zero),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
        // backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 10,
        itemBuilder: (BuildContext context, int index) {
          print('');
          return Center(child: FittedBox(fit: BoxFit.none, child: Text(' This formatting nicer,')));
        },
      ),
    );
  }
}
