import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/post.dart';
import '../repository/post_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
part 'post_list_notifier.g.dart';

@riverpod
class PostListNotifier extends _$PostListNotifier {
  static const int _pageSize = 10;
  var pn = 0;
  late final RefreshController refreshController;
  bool _isMounted = false; // 跟踪挂载状态

  @override
  AsyncValue<List<Post>> build() {
    _isMounted = true;
    // 注册销毁回调（替代 dispose 方法）
    ref.onDispose(() {
      // 在这里释放资源，比如销毁控制器
      refreshController.dispose();
      // 还可以添加其他需要释放的资源，如取消网络请求、清空状态等
      print("PostListNotifier 已销毁，资源已释放");
      _isMounted = false;
    });

    print("build=====");
    refreshController = RefreshController(initialRefresh: false);
    refresh();
    return const AsyncValue.loading();
    // return AsyncValue.data([]); // 初始状态为空列表
  }

  // 下拉刷新
  Future<void> refresh() async {
    print("refresh=====");
    // state=AsyncValue.loading();
    //AsyncValue.guard  自动处理异常 （）
    var asyncValue = await AsyncValue.guard(
      () async => await ref
          .read(postRepositoryProvider)
          .fetchPosts(pn = 0, _pageSize, refreshController: refreshController),
    );
    print('------------------------1 ${asyncValue.error}');
    state = asyncValue;
    refreshController.refreshCompleted();
    print('------------------------2'); //如何有异常抛出也会走完这个方法，因为AsyncValue.guard已经处理了，直接返回到页面的error的回调了
  }

  // 上拉加载更多
  Future<void> loadMore() async {
    final previousState = state;

    // 如果当前状态是加载中或错误，不执行新的加载
    if (previousState.isLoading || previousState.hasError) return;

    final currentPosts = previousState.valueOrNull ?? [];

    pn++;
    try {
      final newPosts = await ref.read(postRepositoryProvider).fetchPosts(pn, _pageSize);

      // 如果没有更多数据，显示没有更多内容
      if (newPosts.isEmpty) {
        state = AsyncValue.data([...currentPosts, Post(id: -1, title: '没有更多内容', content: '')]);
        return;
      }
      // 更新状态，合并新旧数据
      state = AsyncValue.data([...currentPosts, ...newPosts]);
      refreshController.loadComplete();
    } catch (error, stackTrace) {
      pn--;
      // // 恢复之前的状态并显示错误
      // state = AsyncValue.error(error, stackTrace);
      // // 可选：显示错误提示（如 SnackBar）
      print("出错！");

      // 1.失败时恢复之前的状态，仅更新错误信息
      state = previousState.copyWithPrevious(isRefresh: true, previousState);

      //2.如果想保持原来的页面数据不变,直接原来状态给他
      // state=previousState;

      // 通过 navigatorKey 访问 context
      final context = navigatorKey.currentContext;
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text('加载失败，请重试 $stackTrace')));

      Future.delayed(Duration(milliseconds: 500), () {
        // 自定义一个是否挂载的 Provider
        if (_isMounted) {
          print("loadComplete...");
          refreshController.loadComplete();//调用这个方法 loading 才会消失 变成上拉加载更多提示
        }
      });
    }
  }
}
