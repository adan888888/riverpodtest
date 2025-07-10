import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


// 2. StateProvider 定义一个简单的状态提供者
final counterProvider = StateProvider((ref) => 0);
void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Riverpod 示例')),
        body: Center(child: Text('计数: $count')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref.read(counterProvider.notifier).update((state) => state + 1),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
