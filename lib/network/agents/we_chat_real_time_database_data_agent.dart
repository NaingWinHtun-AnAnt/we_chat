import 'dart:io';

import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/data/vos/message_vo.dart';

abstract class WeChatRealTimeDatabaseDataAgent {
  /// create conversation
  Future<void> createConversation(String userId, ConversationVO conversation);

  /// conversation
  Stream<List<ConversationVO>> getConversations(String userId);

  /// chat
  Stream<List<MessageVO>> getMessages(int conversationId, String userId);

  /// send message
  Future sendMessage(int conversationId, MessageVO message, String userId);

  /// upload file
  Future<String> uploadFileToFirebaseStorage(File file, String folderName);
}
