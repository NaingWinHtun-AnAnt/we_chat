import 'package:we_chat/data/vos/user_vo.dart';

abstract class UserModel {
  /// get my data
  Future<UserVO> getUser();

  /// get scan user By id
  Stream<UserVO> getUserById(String userId);
}
