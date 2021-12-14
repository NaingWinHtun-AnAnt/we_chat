import 'dart:io';

import 'package:we_chat/data/vos/message_vo.dart';

abstract class WeChatRealTimeDatabaseDataAgent {
  /// chat
  Stream<List<MessageVO>> getMessages(String sendUserId, String receiveUserId);

  /// send message
  Future sendMessage(
      String sendUserId, MessageVO message, String receiveUserId);

  /// upload file
  Future<String> uploadFileToFirebaseStorage(File file, String folderName);
}
