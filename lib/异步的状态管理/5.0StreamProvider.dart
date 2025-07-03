import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// StreamProvider
// 用于持续发出数据（适合 WebSocket、传感器、定时器等）
// ref.watch()
// 自动监听状态变化并刷新 UI
// .when()
// 处理加载中 / 数据 / 错误状态
// 自动取消
// 当组件卸载时，Stream 会被自动取消（资源释放）
final counterStreamProvider = StreamProvider<int>((ref) async* {
  int count = 0;
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    // 向 Stream 发送一个数据
    yield count++; //将当前 count 的值发送给 Stream 的订阅者，然后再把 count 自增 1。
  }
});

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: StreamCounterPage(),
    );
  }
}

class StreamCounterPage extends ConsumerWidget {
  const StreamCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterAsync = ref.watch(counterStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StreamProvider 示例')),
      body: Center(
        child: counterAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('出错了: $err'),
          data: (value) => Text('当前值：$value', style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}
