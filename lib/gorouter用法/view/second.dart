import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../3.0StateNotifierProvider.dart';
import '../router/app_route_path.dart';

class LoginScreen extends StatelessWidget {
  final User? user;

  const LoginScreen({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('传过来的值是： ${user?.name}')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pushReplacement(homeRouter);
          },
          child: Text("🔙返回"),
        ),
      ),
    );
  }
}
