import 'package:we_chat/data/models/contact_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/contact_vo.dart';
import 'package:we_chat/network/agents/cloud_fire_store_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_cloud_firestore_data_agent.dart';

class ContactModelImpl extends ContactModel {
  static final ContactModelImpl _singleton = ContactModelImpl._internal();

  factory ContactModelImpl() => _singleton;

  ContactModelImpl._internal();

  /// real time database
  final WeChatCloudFireStoreDataAgent _dataAgent =
      CloudFireStoreDataAgentImpl();

  /// add contact to mine
  @override
  Future<void> addContact(String myId, ContactVO contact) {
    return _dataAgent.addContact(myId, contact).then(
      (value) {
        _craftMyContact().then(
          (value) => _dataAgent.addContact(
            contact.id,
            value,
          ),
        );
      },
    );
  }

  Future<ContactVO> _craftMyContact() {
    return UserModelImpl().getUser().then((value) {
      final myContact = ContactVO(
        id: value.id ?? "",
        userName: value.userName,
        email: value.email,
        imagePath: value.imagePath,
        organization: value.organization,
      );
      return Future.value(myContact);
    });
  }

  /// get contact list
  @override
  Stream<List<ContactVO>> getContact(String userId) {
    return _dataAgent.getContact(userId);
  }
}
