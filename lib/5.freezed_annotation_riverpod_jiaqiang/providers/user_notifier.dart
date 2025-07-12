import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_notifier.g.dart';

class UserRepository {
  Future<User> getUser(int id) async {
    await Future.delayed(const Duration(seconds: 3)); // 模拟网络延迟
    return User(
      id: '$id',
      name: 'User $id',
      age: 20 + id,
      avatarUrl: 'https://i.pravatar.cc/150?img=$id',
    );
  }
}

final userRepositoryProvider = Provider((ref) => UserRepository());

@riverpod
class UserNotifier extends _$UserNotifier {
  bool _isDisposed = false;

  @override
  FutureOr<User> build(int userId) async {

    // 监听 Provider 销毁事件
    ref.onDispose(() {
      _isDisposed = true;
    });
    // 自动在 watch 时加载数据
    final user = await ref.read(userRepositoryProvider).getUser(userId);
    return user;
  }

  //返回AsyncValue方式
  // @override
  // AsyncValue<User> build(int userId)  {
  //   return AsyncValue.loading();
  // }

  Future<void> fetchUser(int id) async {
    // state = const AsyncValue.loading();
    final newState  = await AsyncValue.guard(() => ref.read(userRepositoryProvider).getUser(id));
    // 只有当 Widget 还挂载时才更新状态
    if (!_isDisposed) {
      state = newState;
    }
  }
}
