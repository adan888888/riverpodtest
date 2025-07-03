import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Provider 提供不可变数据（如配置、服务实例），不支持直接修改
// *无论调用多少次 ref.watch(configProvider)，都将返回同一个 AppConfig 实例*。
final configProvider = StateProvider((ref) {
  return AppConfig(apiBaseUrl: 'https://api.example.com', isDebugMode: false);
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cg = ref.watch(configProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Riverpod 示例')),
        body: Center(child: Text('计数: ${cg.apiBaseUrl}')),
        floatingActionButton: FloatingActionButton(onPressed: () => ref.read(configProvider.notifier).update((state) => state.copyWith(
            apiBaseUrl: 'new-url',   //只能过ref.read来修改 ，其它的方式不允许
          )), child: Icon(Icons.add)),
      ),
    );
  }
}

class AppConfig {
  final String? apiBaseUrl;
  final bool? isDebugMode;

  AppConfig({required this.apiBaseUrl, required this.isDebugMode});

  AppConfig copyWith({String? apiBaseUrl, bool? isDebugMode}) {
    return AppConfig(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      isDebugMode: isDebugMode ?? this.isDebugMode,
    );
  }
}
