import 'package:we_chat/data/models/conversation_model.dart';
import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/network/agents/real_time_database_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_real_time_database_data_agent.dart';

class ConversationModelImpl extends ConversationModel {
  /// data agent
  final WeChatRealTimeDatabaseDataAgent _mDataAgent =
      RealTimeDatabaseDataAgentImpl();

  static final ConversationModelImpl _singleton =
      ConversationModelImpl._internal();

  factory ConversationModelImpl() => _singleton;

  ConversationModelImpl._internal();

  /// create conversation
  @override
  Future<void> createConversation(String userId, ConversationVO conversation) {
    return _mDataAgent.createConversation(userId, conversation);
  }

  /// get conversation lists
  @override
  Stream<List<ConversationVO>> getConversations(String userId) {
    return _mDataAgent.getConversations(userId);
  }
}
