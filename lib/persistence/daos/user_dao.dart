import 'package:hive/hive.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/dummy_data.dart';
import 'package:we_chat/persistence/hive_constants.dart';

class UserDao {
  static final UserDao _singleton = UserDao._internal();

  factory UserDao() => _singleton;

  UserDao._internal();

  /// save user
  void saveUser(UserVO? user) async {
    /// create user if no user in hive and parameter value is not null
    if (user != null && getUser() == null) {
      await getUserBox().put(user.id, user);
    }
  }

  UserVO? getUser() {
    return dummyUser;
  }

  /// reactive programming set up
  /// watch user box
  Stream<void> getUserEventStream() {
    return getUserBox().watch();
  }

  Stream<UserVO?>? getUserStream() {
    return Stream.value(getUser());
  }

  UserVO? getLoginUser() {
    return getUser();
  }

  Box<UserVO> getUserBox() {
    return Hive.box(boxNameUserVO);
  }
}
