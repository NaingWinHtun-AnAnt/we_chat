import 'dart:io';

import 'package:we_chat/data/vos/message_vo.dart';

abstract class ChatModel {
  Stream<List<MessageVO>> getMessages(String sendUserId, String receiveUserId);

  /// send message
  Future sendMessage(
    String sendUserId,
    String receiveUserId,
    String receiverUserName,
    String receiverProfilePath,
    String? text,
    File? file,
    bool isVideoFile,
  );
}
