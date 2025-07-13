import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateNotifierProvider 是一种用于管理具有更复杂业务逻辑的状态的方式。
/// 它结合了 StateNotifier 和 Provider，适合用于多个组件共享的状态，或者状态变化中包含逻辑处理的情况。
// class CounterNotifier extends StateNotifier<int> {
//   CounterNotifier() : super(0); // 初始状态为0
//
//   void increment() => state++;
//   void decrement() => state--;
// }
//假如是一个对象
class CounterNotifier extends StateNotifier<User> {
  CounterNotifier() : super(User(name: 'Tom', age: 20));

  void updateName(String newName) => state = state.copyWith(name: newName);

  void updateAge(int newAge) => state = state.copyWith(age: newAge);
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}

/*
	•	使用 ref.watch() 来监听用户状态变化。
	•	使用 ref.read().notifier 来触发更新。
	•	UI 中通过 TextField 修改姓名，按钮点击修改年龄。
* */
class MyApp extends ConsumerWidget {
  //定义 StateNotifierProvider
  final counterProvider = StateNotifierProvider<CounterNotifier, User>((ref) => CounterNotifier());

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(counterProvider); // 监听 状态
    final userNotifier = ref.read(counterProvider.notifier); // 获取Notifier 以便修改状态

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Riverpod StateNotifier 示例')),
        body: Center(
          child: Column(
            children: [
              Text('姓名：${user.name}', style: TextStyle(fontSize: 20)),
              Text('年龄：${user.age}', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 30),

              TextField(decoration: const InputDecoration(labelText: '更新姓名'), onSubmitted: (value) => userNotifier.updateName(value)),

              const SizedBox(height: 10),

              ElevatedButton(onPressed: () => userNotifier.updateAge(user.age + 1), child: const Text('年龄 +1')),
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int age;
  User({required this.name, required this.age});

  User copyWith({String? name, int? age}) {
    return User(name: name ?? this.name, age: age ?? this.age);
  }
}
