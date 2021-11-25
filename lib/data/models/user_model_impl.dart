import 'package:stream_transform/stream_transform.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/dummy_data.dart';
import 'package:we_chat/persistence/daos/user_dao.dart';

class UserModelImpl extends UserModel {
  static final UserModelImpl _singleton = UserModelImpl._internal();

  factory UserModelImpl() => _singleton;

  UserModelImpl._internal();

  /// daos
  final UserDao _mUserDao = UserDao();

  /// from network
  @override
  Stream<List<UserVO>> getContactList() {
    return Stream.value([
      UserVO(
        id: 5668866,
      ),
    ]);
  }

  /// get user by Id
  @override
  Stream<UserVO> getUserById(String userId) {
    return Stream.value(
      UserVO(
        id: 5668866,
      ),
    );
  }

  @override
  Future createContact(String? userId) {
    return Future.value();
  }

  /// local database(hive)
  @override
  void createUser() {
    _mUserDao.saveUser(dummyUser);
  }

  /// from database
  @override
  Stream<UserVO?>? getUser() {
    return _mUserDao
        .getUserEventStream()
        .startWith(_mUserDao.getUserStream())
        .map(
          (event) => _mUserDao.getLoginUser(),
        );
  }
}
