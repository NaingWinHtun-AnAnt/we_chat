import 'package:we_chat/data/vos/message_vo.dart';

abstract class ConversationModel {
  /// get recent chat list
  Stream<MessageVO> getConversations(String myId, String contactId);
}
