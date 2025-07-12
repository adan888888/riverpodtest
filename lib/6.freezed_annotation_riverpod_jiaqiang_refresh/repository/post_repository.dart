import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';

class PostRepository {
  // 模拟分页加载数据
  Future<List<Post>> fetchPosts(int pageNm, int pageSize) async {
    await Future.delayed(const Duration(seconds: 2));

    // 模拟随机错误
    if (DateTime.now().second % 8 == 0) {
      throw Exception('网络请求失败，请重试');
    }
    
    // 生成模拟数据
    return List.generate(pageSize, (index) {
      final id = (pageNm - 1) * pageSize + index + 1;
      return Post(
        id: id,
        title: '文章 $id',
        content: '这是文章 $id 的内容...',
        avatarUrl: index%2==0?'https://p0.meituan.net/imgupload/46e02584d5eeb061e3df48a091c1ebbf49200.webp%40watermark%3D0':'https://img0.baidu.com/it/u=1725976679,2529022150&fm=253&fmt=auto&app=138&f=JPEG?w=380&h=380'
      );
    });
  }
}

final postRepositoryProvider = Provider((ref) => PostRepository());