import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'providers/post_list_notifier.dart';

// 1. 在 main.dart 中定义全局 NavigatorKey
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // 设置导航键
      home: const PostListScreen(),
    );
  }
}

/*class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {

  @override
  void initState() {
    super.initState();
    print("initState");
    // 初始加载
    Future.microtask(() => ref.read(postListNotifierProvider.notifier).refresh());
  }

  @override
  void dispose() {
    // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postList = ref.watch(postListNotifierProvider);
    var read = ref.read(postListNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('文章列表')),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: ref.read(postListNotifierProvider.notifier).refreshController,
        onRefresh: () => read.refresh(),
        onLoading: () => ref.read(postListNotifierProvider.notifier).loadMore(),
        child: postList.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            setState(() {});//成功 失败 的状态消失
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: $error'),
                  ElevatedButton(onPressed: () => read.refresh(), child: const Text('重试')),
                ],
              ),
            );
          },
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
                  contentPadding: EdgeInsets.only(left: 10),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 56, height: 60),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey, // 填充色（可选）
                      backgroundImage: NetworkImage(
                        scale: 1,
                        post.avatarUrl ??
                            "https://c-ssl.dtstatic.com/uploads/blog/202405/03/73SmDPGxIeB0Gel.thumb.1000_0.jpg",
                      ),
                    ),
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
}*/

class PostListScreen extends ConsumerWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postListNotifierProvider);
    var read = ref.read(postListNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('文章列表')),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: read.refreshController,
        onRefresh: () => read.refresh(),
        onLoading: () => read.loadMore(),
        child: postList.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$error'),
                    ElevatedButton(onPressed: () => read.refresh(), child: const Text('重试')),
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
                  contentPadding: EdgeInsets.only(left: 10),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 56, height: 60),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey, // 填充色（可选）
                      backgroundImage: NetworkImage(
                        scale: 1,
                        post.avatarUrl ??
                            "https://c-ssl.dtstatic.com/uploads/blog/202405/03/73SmDPGxIeB0Gel.thumb.1000_0.jpg",
                      ),
                    ),
                  ),
                  title: Text('${post.title}'),
                  subtitle: Text('${post.content}'),
                  onTap: () {},
                  // 当滚动到倒数第二个项目时，触发加载更多
                  onLongPress: () {
                    if (index == posts.length - 2) {
                      read.loadMore();
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
