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
  Stream<List<MessageVO>> getMessages(String sendUserId, String receiveUserId) {
    return _mDataAgent.getMessages(sendUserId, receiveUserId);
  }

  @override
  Future sendMessage(
    String sendUserId,
    String receiveUserId,
    String receiverUserName,
    String receiverProfilePath,
    String? text,
    File? file,
    bool isVideoFile,
  ) {
    if (file != null) {
      /// write message in sender node first and then the receiver
      return _mDataAgent
          .uploadFileToFirebaseStorage(file, folderMessageFile)
          .then(
            (fileUrl) => _craftMessageVO(
              sendUserId,
              receiveUserId,
              isVideoFile,
              text,
              receiverUserName,
              receiverProfilePath,
              fileUrl: fileUrl,
            ).then(
              (message) => _mDataAgent
                  .sendMessage(sendUserId, message, receiveUserId)
                  .then((value) => _mDataAgent.sendMessage(
                      receiveUserId, message, sendUserId)),
            ),
          );
    } else {
      /// write message in sender node first and then the receiver
      return _craftMessageVO(
        sendUserId,
        receiveUserId,
        isVideoFile,
        text,
        receiverUserName,
        receiverProfilePath,
      ).then(
        (message) => _mDataAgent
            .sendMessage(sendUserId, message, receiveUserId)
            .then((value) =>
                _mDataAgent.sendMessage(receiveUserId, message, sendUserId)),
      );
    }
  }

  Future<MessageVO> _craftMessageVO(
    String userId,
    String receiveUserId,
    bool isVideoFile,
    String? text,
    String receiverUserName,
    String receiverProfilePath, {
    String? fileUrl,
  }) {
    /// prepare message
    final mMessage = MessageVO(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      receiveUserId: receiveUserId,
      isVideoFile: isVideoFile,
      fileUrl: fileUrl,
      receiverProfilePath: receiverProfilePath,
      receiverUserName: receiverUserName,
      message: text,
    );
    return Future.value(mMessage);
  }
}
