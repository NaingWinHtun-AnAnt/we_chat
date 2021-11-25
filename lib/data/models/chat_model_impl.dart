import 'dart:io';

import 'package:we_chat/data/models/chat_model.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/network/agents/real_time_database_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_real_time_database_data_agent.dart';
import 'package:we_chat/network/firebase_constants.dart';

class ChatModelImpl extends ChatModel {
  /// data agent
  final WeChatRealTimeDatabaseDataAgent _mDataAgent =
      RealTimeDatabaseDataAgentImpl();

  static final ChatModelImpl _singleton = ChatModelImpl._internal();

  factory ChatModelImpl() => _singleton;

  ChatModelImpl._internal();

  @override
  Stream<List<MessageVO>> getMessages(int conversationId, int userId) {
    return _mDataAgent.getMessages(conversationId, userId);
  }

  @override
  Future sendMessage(
    int messageId,
    int conversationId,
    String? text,
    File? file,
    bool isVideoFile,
    int userId,
  ) {
    if (file != null) {
      return _mDataAgent
          .uploadFileToFirebaseStorage(file, folderMessageFile)
          .then(
            (fileUrl) => _craftMessageVO(messageId, userId, isVideoFile, text,
                    fileUrl: fileUrl)
                .then(
              (message) =>
                  _mDataAgent.sendMessage(conversationId, message, userId),
            ),
          );
    } else {
      return _craftMessageVO(messageId, userId, isVideoFile, text).then(
        (message) => _mDataAgent.sendMessage(conversationId, message, userId),
      );
    }
  }

  Future<MessageVO> _craftMessageVO(
    int messageId,
    int userId,
    bool isVideoFile,
    String? text, {
    String? fileUrl,
  }) {
    /// prepare message
    final mMessage = MessageVO(
      id: messageId,
      userId: userId,
      isVideoFile: isVideoFile,
      fileUrl: fileUrl,
      message: text,
    );
    return Future.value(mMessage);
  }
}
