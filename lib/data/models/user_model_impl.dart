import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/agents/cloud_fire_store_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_cloud_firestore_data_agent.dart';

class UserModelImpl extends UserModel {
  static final UserModelImpl _singleton = UserModelImpl._internal();

  factory UserModelImpl() => _singleton;

  UserModelImpl._internal();

  /// real time database
  final WeChatCloudFireStoreDataAgent _dataAgent =
      CloudFireStoreDataAgentImpl();

  /// get my user data
  @override
  Future<UserVO> getUser() {
    return _dataAgent.getLoginUser();
  }

  /// get user by scan user id
  @override
  Stream<UserVO> getUserById(String userId) {
    return _dataAgent.getUserById(userId);
  }
}
