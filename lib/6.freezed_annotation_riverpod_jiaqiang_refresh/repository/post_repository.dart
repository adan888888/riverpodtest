import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/post.dart';

class PostRepository {
  // 模拟分页加载数据
  Future<List<Post>> fetchPosts(int pageNm, int pageSize, {RefreshController? refreshController}) async {
    await Future.delayed(const Duration(seconds: 1));
     print('fetchPosts==');
    // 模拟随机错误
    if (DateTime.now().second % 2 == 0) {
      print("抛出异常！");
      // refreshController?.refreshCompleted();
      throw Exception('网络请求失败，请重试');
    }

    // 生成模拟数据
     var list = List.generate(pageSize, (index) {
      final id = pageNm * pageSize + index + 1;
      return Post(
        id: id,
        title: '文章 $id',
        content: '这是文章 $id 的内容...',
        avatarUrl:
            index % 2 == 0
                ? 'https://p0.meituan.net/imgupload/46e02584d5eeb061e3df48a091c1ebbf49200.webp%40watermark%3D0'
                : 'https://img0.baidu.com/it/u=1725976679,2529022150&fm=253&fmt=auto&app=138&f=JPEG?w=380&h=380',
      );
    });
    print(list.length);
    return list;
  }
}

final postRepositoryProvider = Provider((ref) => PostRepository());
