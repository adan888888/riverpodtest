import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';


/// FutureProvider 本身不能暴露方法供外部直接更新状态
final usernameProvider = FutureProvider<String>((ref) async {
  // 模拟网络延迟
  await Future.delayed(Duration(seconds: 2));
  // 模拟接口返回的数据
  return '张三';
});

void main() {
  runApp(ProviderScope(child: const MyApp()));
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
      home: UserNamePage(),
    );
  }
}

class UserNamePage extends ConsumerWidget {
  const UserNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUsername = ref.watch(usernameProvider);
    return Scaffold(
      appBar: AppBar(title: Text('FutureProvider 示例')),
      body: Center(
        child: Column(
          children: [
            asyncUsername.when(
              loading: () => CircularProgressIndicator(),
              error: (err, stack) => Text('加载失败: $err'),
              data: (username) => Text('欢迎你，$username', style: TextStyle(fontSize: 24)),
            ),
            TextButton(onPressed: () {
              ref.invalidate(usernameProvider);
            }, child:  const Text('重新加载刷新'))
          ],
        ),
      ),
    );
  }
}
