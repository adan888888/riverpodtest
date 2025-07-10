import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User build() {
    // 初始状态：游客用户
    return const User(name: 'Guest', age: 100, address: "深圳");
  }

  // 更新用户信息
  void updateUserInfo({String? name, int? age, String? avatarUrl}) {
    state = state.copyWith(
      name: name ?? state.name,
      age: age ?? state.age,
      avatarUrl: avatarUrl ?? state.avatarUrl,
    );
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
