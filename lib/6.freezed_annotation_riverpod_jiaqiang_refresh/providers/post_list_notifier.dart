import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/post.dart';
import '../repository/post_repository.dart';
part 'post_list_notifier.g.dart';

@riverpod
class PostListNotifier extends _$PostListNotifier {
  static const int _pageSize = 10;

  @override
  AsyncValue<List<Post>> build() {
    print("build=====");
    refresh();
    return const AsyncValue.loading();
  }

  // 下拉刷新
  Future<void> refresh() async {
    await AsyncValue.guard(() async {
      final posts = await ref.read(postRepositoryProvider).fetchPosts(1, _pageSize);
      state = AsyncValue.data(posts);
      print("refresh=====");
      return posts;
    });
  }

  // 上拉加载更多
  Future<void> loadMore() async {
    final currentState = state;

    // 如果当前状态是加载中或错误，不执行新的加载
    if (currentState.isLoading || currentState.hasError) return;

    final currentPosts = currentState.valueOrNull ?? [];
    final nextPage = (currentPosts.length / _pageSize).ceil() + 1;

    // 显示加载更多指示器（添加一个 null 占位符）
    // state = AsyncValue.data([...currentPosts, Post()]);

    try {
      final newPosts = await ref.read(postRepositoryProvider).fetchPosts(nextPage, _pageSize);

      // 如果没有更多数据，显示没有更多内容
      if (newPosts.isEmpty) {
        state = AsyncValue.data([...currentPosts, Post(id: -1, title: '没有更多内容', content: '')]);
        return;
      }

      // 更新状态，合并新旧数据
      state = AsyncValue.data([...currentPosts, ...newPosts]);
    } catch (error, stackTrace) {
      // 恢复之前的状态并显示错误
      state = AsyncValue.error(error, stackTrace);
      // 可选：显示错误提示（如 SnackBar）
      print("出错！");
    }
  }
}
