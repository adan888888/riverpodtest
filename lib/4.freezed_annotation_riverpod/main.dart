import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtest/4.freezed_annotation_riverpod/providers/user_provider.dart';

void main() {
  runApp(
    // 提供Riverpod的ProviderScope
    ProviderScope(
      child: MaterialApp(
        title: 'Riverpod User Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const UserScreen(),
      ),
    ),
  );
}

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    final read = ref.read(userControllerProvider.notifier);
    switch (user) {
      case value:
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [if (user.isPremium == true) const Icon(Icons.star, color: Colors.yellow)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 用户头像
            if (user.avatarUrl != null)
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.avatarUrl!))
            else
              const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 20),

            // 用户信息
            Text('Name: ${user.name}', style: Theme.of(context).textTheme.titleLarge),
            Text('Age: ${user.age}', style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 40),

            // 操作按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => read.loadUser('1'), child: const Text('Load User')),

                ElevatedButton(
                  onPressed: () {
                    read.updateUserInfo(
                      name: 'Jane Smith',
                      age: 25,
                      avatarUrl: 'https://picsum.photos/id/65/200/200',
                    );
                  },
                  child: const Text('Update Info'),
                ),

                ElevatedButton(
                  onPressed: () => read.upgradeToPremium(),
                  child: const Text('Go Premium'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
