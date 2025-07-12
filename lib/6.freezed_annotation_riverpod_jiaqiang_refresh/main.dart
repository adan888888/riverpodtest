import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'providers/post_list_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PostListScreen());
  }
}

class PostListScreen extends ConsumerWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EasyRefreshController refreshController = EasyRefreshController(controlFinishLoad: false);
    final postList = ref.watch(postListNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('文章列表')),
      body: EasyRefresh(
        controller: refreshController,
        onRefresh: () => ref.read(postListNotifierProvider.notifier).refresh(),
        onLoad: () => ref.read(postListNotifierProvider.notifier).loadMore(),
        child: postList.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: $error'),
                    ElevatedButton(
                      onPressed: () => ref.read(postListNotifierProvider.notifier).refresh(),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
          data: (posts) {
            if (posts.isEmpty) {
              return const Center(child: Text('暂无数据'));
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                // 处理没有更多内容
                if (post.content == "没有更多内容") {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('已加载全部内容', style: TextStyle(color: Colors.grey)),
                    ),
                  );
                }

                // 处理正常文章项
                return ListTile(
                  trailing: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(post.avatarUrl??"https://c-ssl.dtstatic.com/uploads/blog/202405/03/73SmDPGxIeB0Gel.thumb.1000_0.jpg"),
                  ),
                  title: Text('${post.title}'),
                  subtitle: Text('${post.content}'),
                  onTap: () {},
                  // 当滚动到倒数第二个项目时，触发加载更多
                  onLongPress: () {
                    if (index == posts.length - 2) {
                      ref.read(postListNotifierProvider.notifier).loadMore();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
