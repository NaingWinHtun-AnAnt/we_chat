import 'package:we_chat/data/vos/conversation_vo.dart';

abstract class ConversationModel {
  /// create conversation
  Future<void> createConversation(String userId, ConversationVO conversation);

  /// get all conversation for user
  Stream<List<ConversationVO>> getConversations(String userId);
}
