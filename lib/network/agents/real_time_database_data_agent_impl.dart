import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  /// chat
  @override
  Stream<List<MessageVO>> getMessages(String sendUserId, String receiveUserId) {
    return _dbReference
        .child(nodeContactsAndMessages)
        .child(sendUserId)
        .child(receiveUserId)
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
  Future sendMessage(
    String sendUserId,
    MessageVO message,
    String receiveUserId,
  ) {
    return _dbReference
        .child(nodeContactsAndMessages)
        .child(sendUserId)
        .child(receiveUserId)
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
