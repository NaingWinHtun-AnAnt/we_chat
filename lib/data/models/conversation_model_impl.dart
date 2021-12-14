import 'package:we_chat/data/models/conversation_model.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/network/agents/real_time_database_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_real_time_database_data_agent.dart';

class ConversationModelImpl extends ConversationModel {
  static final ConversationModelImpl _singleton =
      ConversationModelImpl._internal();

  factory ConversationModelImpl() {
    return _singleton;
  }

  ConversationModelImpl._internal();

  /// data agent
  final WeChatRealTimeDatabaseDataAgent _dataAgent =
      RealTimeDatabaseDataAgentImpl();

  @override
  Stream<MessageVO> getConversations(String myId, String contactId) {
    return _dataAgent.getMessages(myId, contactId).map((event) => event.last);
  }
}
