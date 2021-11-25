import 'dart:io';

import 'package:we_chat/data/vos/message_vo.dart';

abstract class ChatModel {
  Stream<List<MessageVO>> getMessages(int conversationId, int userId);

  /// send message
  Future sendMessage(
    int messageId,
    int conversationId,
    String? text,
    File? file,
    bool isVideoFile,
    int userId,
  );
}