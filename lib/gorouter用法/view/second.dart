import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  //第1种 对象接收参数
  // final User? user;
  // const LoginScreen({super.key,required this.user});

  //第2种：queryParameters
  final GoRouterState? state;
  LoginScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // 解析 queryParameters（URL参数）
    final String id = state?.uri.queryParameters['id'] ?? '';
    final String name = state?.uri.queryParameters['name'] ?? '';
    final bool isVip = state?.uri.queryParameters['isVip'] == 'true';
    return Scaffold(
      appBar: AppBar(title: Text('第二个页面')),
      body: Center(
        child: Column(
          children: [
            Text("ID是：$id"),
            Text("名字是：$name"),
            Text("是否是VIP：$isVip"),
            ElevatedButton(
              onPressed: () {
                // 返回任意类型的数据（这里返回Map）
                final result = {
                  'status': 'success',
                  'message': '操作完成',
                  'timestamp': DateTime.now().toString(),
                };
                context.pop(result); // 关闭当前页面并传递数据
              },
              child: Text("🔙返回"),
            ),
          ],
        ),
      ),
    );
  }
}
