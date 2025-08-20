import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
/// FutureProvider 本身不能暴露方法供外部直接更新状态
// 记录每次请求的触发时间和完成时间
int _requestId = 0;
final usernameProvider = FutureProvider<String>((ref) async {
  _requestId++;
  final requestId = _requestId;
  final startTime = DateTime.now();

  // 模拟2秒网络延迟
  await Future.delayed(Duration(seconds: 2));

  final endTime = DateTime.now();
  return '张三（第 $requestId 次请求，耗时: ${endTime.difference(startTime).inSeconds}秒）';
});

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refresh 示例',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserNamePage(),
    );
  }
}

class UserNamePage extends ConsumerWidget {
  const UserNamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUsername = ref.watch(usernameProvider);

    return Scaffold(
      appBar: AppBar(title: Text('FutureProvider 刷新示例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asyncUsername.when(
              loading: () => Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('加载中...（触发第 $_requestId 次请求）'), // 显示当前触发的请求ID
                ],
              ),
              error: (err, stack) => Text('加载失败: $err'),
              data: (username) => Text(
                username,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 调用 refresh 触发重新请求
                ref.invalidate(usernameProvider);
                // ref.refresh(usernameProvider);
              },
              child: Text('点击刷新（使用 refresh）'),
            ),
          ],
        ),
      ),
    );
  }
}
