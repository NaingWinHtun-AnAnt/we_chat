import 'package:we_chat/data/vos/conversation_vo.dart';

abstract class ConversationModel{
  /// get all conversation for user
  Stream<List<ConversationVO>> getConversations(int userId);
}