import 'package:we_chat/data/vos/user_vo.dart';

abstract class UserModel {
  /// from network
  Stream<List<UserVO>> getContactList();

  /// create contact
  Future createContact(String? userId);

  /// get User With Id
  Stream<UserVO> getUserById(String userId);

  /// local database(hive)
  void createUser();

  /// from database
  Stream<UserVO?>? getUser();
}
