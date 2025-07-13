import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_provider.g.dart'; //生成的文件名称

///这个就相当于 StateNotifierProvider的注解版本
///
/// 注解规则，_$后面必须跟class后面的类名
@riverpod
class UserController extends _$UserController {
  // @override
  // User build() {
  //   // 初始状态：游客用户
  //   return const User(name: 'Guest', age: 100, address: "深圳");
  // }
  @override
  User build() => const User(); //初始化

  // 更新用户信息
  Future<void> updateUserInfo({String? name, int? age, String? avatarUrl}) async {
    //1.重新赋值
    state = state.copyWith(
      name: name ?? state.name,
      age: age ?? state.age,
      avatarUrl: avatarUrl ?? state.avatarUrl,
    );
    // ref.invalidate(userControllerProvider);//销毁并重建 Provider(1.所有与该 Provider 关联的状态会被重置为初始值（即 build() 方法的返回值）。2.会执行ondispose)
  }

  // 升级为高级用户
  void upgradeToPremium() {
    state = state.copyWith(isPremium: true);
  }

  // 从API加载用户数据（模拟异步操作）
  Future<void> loadUser(String userId) async {
    // 显示加载状态
    state = state.copyWith(name: 'Loading...', age: 0);

    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 2));

      // 模拟API返回数据
      final mockUser = User(
        id: userId,
        name: 'John Doe',
        age: 30,
        avatarUrl: 'https://picsum.photos/id/64/200/200',
        isPremium: true,
      );

      // 更新状态
      state = mockUser;
    } catch (e) {
      // 错误处理
      state = state.copyWith(name: 'Error loading user', age: 0);
    }
  }
}
