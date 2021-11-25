import 'dart:io';

import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/data/vos/message_vo.dart';

abstract class WeChatRealTimeDatabaseDataAgent {
  /// conversation
  Stream<List<ConversationVO>> getConversations(int userId);

  /// chat
  Stream<List<MessageVO>> getMessages(int conversationId, int userId);

  /// send message
  Future sendMessage(int conversationId, MessageVO message, int userId);

  /// upload file
  Future<String> uploadFileToFirebaseStorage(File file, String folderName);
}
