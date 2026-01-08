import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_notifier.g.dart';

class UserRepository {
  Future<User> getUser(int id) async {
    print("build====> getUser =$id");
    await Future.delayed(const Duration(seconds: 3)); // 模拟网络延迟
    return User(id: '$id', name: 'User $id', age: 20 + id, avatarUrl: 'https://i.pravatar.cc/150?img=$id');
  }
}

final userRepositoryProvider = Provider((ref) => UserRepository());

@riverpod
class UserNotifier extends _$UserNotifier {
  bool _isDisposed = false;

  // 如果你的 build 方法返回 AsyncValue<T>（而非直接 Future<T>），依然会生成 AsyncNotifierProvider，因为 AsyncValue 是 Riverpod 专门用于封装异步状态（加载 / 成功 / 错误）的类型
  //重点： 这里带了参数userId，生成后的 Provider 会变成「带 Family 的自动销毁版本」，通过这个来实现状态隔离
  @override
  Future<User> build(int userId) async {
    print("build====>");
    // 监听 Provider 销毁事件
    ref.onDispose(() {
      _isDisposed = true;
    });
    initGetUsers();
    // 自动在 watch 时加载数据
    return User(
      id: "id",
      name: "name",
      age: 100,
      avatarUrl: "avatarUrl",
    ); //上来给一个默认数据，免得上来就是loading ,但是AsyncValue<User>可以控制的更好
  }

  //返回AsyncValue方式
  // @override
  // AsyncValue<User> build(int userId)  {
  //   return AsyncValue.loading();
  // }

  initGetUsers() async {
    final user = await ref.read(userRepositoryProvider).getUser(userId);
    state = AsyncValue.data(user);
  }

  Future<void> fetchUser(int id) async {
    // state = const AsyncValue.loading(); //触发userState.when 里面的 loading方法
    // final newState  = await AsyncValue.guard(() => ref.read(userRepositoryProvider).getUser(id));
    // 只有当 Widget 还挂载时才更新状态
    if (!_isDisposed) {
      state = User(id: "id", name: "name", age: 100, avatarUrl: "avatarUrl") as AsyncValue<User>;
    }
  }
}
