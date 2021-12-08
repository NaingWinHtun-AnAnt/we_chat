import 'package:we_chat/data/vos/contact_vo.dart';

abstract class ContactModel {
  /// add scan user to contact
  Future<void> addContact(String myId, ContactVO contact);

  /// get contact list
  Stream<List<ContactVO>> getContact(String userId);
}
