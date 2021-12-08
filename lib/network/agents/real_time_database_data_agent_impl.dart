import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/network/agents/we_chat_real_time_database_data_agent.dart';
import 'package:we_chat/network/firebase_constants.dart';

class RealTimeDatabaseDataAgentImpl extends WeChatRealTimeDatabaseDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() => _singleton;

  RealTimeDatabaseDataAgentImpl._internal();

  /// real time data reference
  final _dbReference = FirebaseDatabase.instance.reference();

  /// firebase storage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// create a blank conversation
  @override
  Future<void> createConversation(String userId, ConversationVO conversation) {
    return _dbReference
        .child(nodeUsers)
        .child(userId)
        .child(nodeChats)
        .child("${conversation.id}")
        .set(
          conversation.toJson(),
        );
  }

  /// conversations
  @override
  Stream<List<ConversationVO>> getConversations(String userId) {
    return _dbReference
        .child(nodeUsers)
        .child(userId)
        .child(nodeChats)
        .onValue
        .map(
      (event) {
        return event.snapshot.value.values.map<ConversationVO>((event) {
          return ConversationVO.fromJson(
            Map<String, dynamic>.from(event),
          );
        }).toList();
      },
    );
  }

  /// chat
  @override
  Stream<List<MessageVO>> getMessages(int conversationId, String userId) {
    return _dbReference
        .child(nodeUsers)
        .child(userId)
        .child(nodeChats)
        .child("$conversationId")
        .child(nodeMessages)
        .onValue
        .map(
          (event) => event.snapshot.value.values.map<MessageVO>((event) {
            return MessageVO.fromJson(
              Map<String, dynamic>.from(event),
            );
          }).toList(),
        );
  }

  /// send message just message node
  @override
  Future sendMessage(int conversationId, MessageVO message, String userId) {
    return _dbReference
        .child(nodeUsers)
        .child(userId)
        .child(nodeChats)
        .child("$conversationId")
        .child(nodeMessages)
        .child("${message.id}")
        .set(message.toJson());
  }

  /// upload moment image
  @override
  Future<String> uploadFileToFirebaseStorage(File file, String folderName) {
    return _firebaseStorage
        .ref(folderName)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(file)
        .then(
          (snapShot) => snapShot.ref.getDownloadURL(),
        );
  }
}
