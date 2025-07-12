// 📁 lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtest/5.freezed_annotation_riverpod_jiaqiang/providers/user_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: UserScreen(userId: 1));
  }
}

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key, required this.userId});

  final int userId;

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider(_userId));

    return Scaffold(
      appBar: AppBar(title: const Text('用户信息')),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(userNotifierProvider(_userId).notifier).fetchUser(10);
        },
        child: Center(
          child: userState.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
            data:
                (user) => ListView(
                  children: [
                    CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.avatarUrl)),
                    Text('Name: ${user.name}'),
                    Text('Age: ${user.age}'),
                    Text('ID: ${user.id}'),
                  ],
                ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _userId++); //需要刷新界面的还必须用setState方法(更新内部状态)
          ref.read(userNotifierProvider(_userId).notifier).fetchUser(_userId); //更新provider状态
          // ref.invalidate(userNotifierProvider(_userId));
          // ref.refresh(userNotifierProvider(_userId));  

          // _userId++;
          // ref.read(userNotifierProvider(_userId).notifier).fetchUser(_userId);
          // ref.watch(userNotifierProvider(_userId));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  late int _userId;

  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
    Future.microtask(() {
      //widget树构建完就调一次
      ref.read(userNotifierProvider(_userId).notifier).fetchUser(_userId);
    });
  }
}
