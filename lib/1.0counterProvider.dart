import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Provider 提供不可变数据（如配置、服务实例），不支持直接修改
// final configProvider = Provider((ref) => AppConfig());

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
